//
//  BallsGood.m
//  SAM
//
//  Created by Георгий Зуев on 10/08/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "BallsGood.h"
#import "BallsCount.h"

@interface BallsGood ()

@end

@implementation BallsGood

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%ld,\n %@",self.sizeTime, self.sizeMinuts);
    
    self.sizeMinuts.text = [NSString stringWithFormat:@"Жетонов на %ld %@",self.sizeTime, [self getNumEnding:self.sizeTime]];
    
}



-(NSString *) getNumEnding:(NSInteger) num {
    
    NSArray * endings;
    

    endings = @[@"минута",@"минуты",@"минут"];

    
    num = num%100;
    NSString * result;
    
    if (num >= 11 && num <=19) {
        
        result = endings[2];
        
    }else{
    
        int i = num % 10;
        
            if (i == 1) {
                
                result = endings[0];
                
            }else if( i== 4 || i == 2 || i == 3){
                    
                result = endings[1];
                    
            }else {
                result = endings[2];
            }
        
    }
    
    return result;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)inMyBuyButton:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"payControlller"];
    pvc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:pvc animated:YES completion:nil];
        
//        [self addChildViewController: pvc];
//        pvc.view.frame = self.view.frame;
//        [self.view addSubview:pvc.view];
//        [pvc didMoveToParentViewController: self];
    
   // [self performSegueWithIdentifier:@"pushControll" sender:self];
}
@end
