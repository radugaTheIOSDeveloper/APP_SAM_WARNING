import YandexCheckoutPaymentsApi

final class BankCardRepeatPresenter {

    // MARK: - VIPER

    var router: TokenizationRouterInput!
    var interactor: BankCardRepeatInteractorInput!

    weak var moduleOutput: TokenizationModuleOutput?
    weak var view: TokenizationViewInput?

    weak var contractModuleInput: ContractModuleInput?
    weak var bankCardDataInputModuleInput: BankCardDataInputModuleInput?

    // MARK: - Initialization

    private let inputData: BankCardRepeatModuleInputData

    init(inputData: BankCardRepeatModuleInputData) {
        self.inputData = inputData
    }
}

// MARK: - TokenizationViewOutput

extension BankCardRepeatPresenter: TokenizationViewOutput {
    func setupView() {
        view?.setCustomizationSettings(inputData.customizationSettings)
        presentContract()
    }

    func closeDidPress() {
        moduleOutput?.didFinish(on: self, with: nil)
    }

    private func presentContract() {

        let viewModel = PaymentMethodViewModelFactory.makePaymentMethodViewModel(.bankCard)
        let tokenizeScheme = AnalyticsEvent.TokenizeScheme.recurringCard

        let moduleInputData = ContractModuleInputData(
            shopName: inputData.shopName,
            purchaseDescription: inputData.purchaseDescription,
            paymentMethod: viewModel,
            price: makePriceViewModel(inputData.amount),
            fee: nil,
            shouldChangePaymentMethod: false,
            testModeSettings: inputData.testModeSettings,
            tokenizeScheme: tokenizeScheme,
            isLoggingEnabled: inputData.isLoggingEnabled,
            termsOfService: TermsOfServiceFactory.makeTermsOfService()
        )

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.router.presentContract(inputData: moduleInputData,
                                        moduleOutput: self)
        }
    }
}

// MARK: - BankCardRepeatInteractorOutput

extension BankCardRepeatPresenter: BankCardRepeatInteractorOutput {
    func didFetchPaymentMethod(
        _ paymentMethod: YandexCheckoutPaymentsApi.PaymentMethod) {
        guard let card = paymentMethod.card,
              card.first6.isEmpty == false,
              card.last4.isEmpty == false else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.moduleOutput?.didFinish(on: self, with: .paymentMethodNotFound)
            }
            return
        }
        let cardMask = card.first6 + "******" + card.last4
        let moduleInputData = MaskedBankCardDataInputModuleInputData(
            cardMask: cardMask,
            testModeSettings: inputData.testModeSettings,
            isLoggingEnabled: inputData.isLoggingEnabled,
            analyticsEvent: .screenRecurringCardForm,
            tokenizeScheme: .recurringCard
        )

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.router.presenMaskedBankCardDataInput(
                inputData: moduleInputData,
                moduleOutput: self
            )
        }
    }

    func didFailFetchPaymentMethod(_ error: Error) {
        if let error = error as? PaymentsApiError {
            switch error.errorCode {
            case .invalidRequest, .notSupported:
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.moduleOutput?.didFinish(on: self, with: .paymentMethodNotFound)
                }
            default:
                showError(error)
            }
        } else {
            showError(error)
        }
    }

    func didTokenize(_ tokens: Tokens) {
        moduleOutput?.tokenizationModule(
            self,
            didTokenize: tokens,
            paymentMethodType: .bankCard
        )
    }

    func didFailTokenize(_ error: Error) {
        bankCardDataInputModuleInput?.bankCardDidTokenize(error)
    }

    private func showError(_ error: Error) {
        let authType = AnalyticsEvent.AuthType.withoutAuth
        let scheme = AnalyticsEvent.TokenizeScheme.recurringCard
        let event = AnalyticsEvent.screenError(authType: authType, scheme: scheme)
        interactor.trackEvent(event)

        let message = makeMessage(error)
        contractModuleInput?.hideActivity()
        contractModuleInput?.showPlaceholder(message: message)
    }
}

// MARK: - ContractModuleOutput

extension BankCardRepeatPresenter: ContractModuleOutput {
    func didPressSubmitButton(on module: ContractModuleInput) {
        contractModuleInput = module

        module.hidePlaceholder()
        module.showActivity()

        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.interactor.fetchPaymentMethod(
                paymentMethodId: self.inputData.paymentMethodId
            )
        }
    }

    func didPressChangeAction(on module: ContractModuleInput) {}

    func didPressLogoutButton(on module: ContractModuleInput) {}

    func didFinish(on module: ContractModuleInput) {
        moduleOutput?.didFinish(on: self, with: nil)
    }

    func contractModule(_ module: ContractModuleInput, didTapTermsOfService url: URL) {
        router.presentTermsOfServiceModule(url)
    }
}

// MARK: - MaskedBankCardDataInputModuleOutput

extension BankCardRepeatPresenter: MaskedBankCardDataInputModuleOutput {
    func didPressCloseBarButtonItem(on module: BankCardDataInputModuleInput) {
        moduleOutput?.didFinish(on: self, with: nil)
    }

    func didPressConfirmButton(on module: BankCardDataInputModuleInput, cvc: String) {
        bankCardDataInputModuleInput = module

        let confirmation = Confirmation(
            type: .redirect,
            returnUrl: "https://custom.redirect.url/"
        )

        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.interactor.tokenize(
                amount: MonetaryAmountFactory.makePaymentsMonetaryAmount(self.inputData.amount),
                confirmation: confirmation,
                paymentMethodId: self.inputData.paymentMethodId,
                csc: cvc
            )
        }
    }
}

// MARK: - TokenizationModuleInput

extension BankCardRepeatPresenter: TokenizationModuleInput {
    public func start3dsProcess(requestUrl: String, redirectUrl: String) {}
    public func start3dsProcess(requestUrl: String) {}
}

// MARK: - Private global helpers

private func makePriceViewModel(_ amount: Amount) -> PriceViewModel {
    let amountString = amount.value.description
    var integerPart = ""
    var fractionalPart = ""

    if let separatorIndex = amountString.firstIndex(of: ".") {
        integerPart = String(amountString[amountString.startIndex..<separatorIndex])
        fractionalPart = String(amountString[amountString.index(after: separatorIndex)..<amountString.endIndex])
    } else {
        integerPart = amountString
        fractionalPart = "00"
    }
    return TempAmount(currency: amount.currency.symbol,
                      integerPart: integerPart,
                      fractionalPart: fractionalPart,
                      style: .amount)
}

private func makeMessage(_ error: Error) -> String {
    let message: String

    switch error {
    case let error as PresentableError:
        message = error.message
    default:
        message = §CommonLocalized.Error.unknown
    }

    return message
}
