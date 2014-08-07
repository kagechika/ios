//
//  ViewController.m
//  DollarYen
//
//  Created by okitokagechika on 2014/04/05.
//
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController
{
    double input;
    double result;
    double rate;
    
    BOOL isYenToDollar;
    
    IBOutlet UILabel *inputCurrency;
    IBOutlet UILabel *resultCurrency;
    IBOutlet UILabel *rateLabel;
    IBOutlet UILabel *resultLabel;
    
    // segmented controlのインスタンス
    IBOutlet UISegmentedControl *selector;
    IBOutlet UITextField *inputField;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    rate = 80.5;
    input = 0;
    result = 0;
    
    [rateLabel setText:[NSString stringWithFormat:@"%.1f", rate]];
    isYenToDollar = YES;
    
    // inputFieldのDelegate通知をViewControllerで受け取る
    inputField.delegate = self;
}

-(void)convert
{
    if(isYenToDollar == YES){
        result = input/ rate;
        [rateLabel setText:[NSString stringWithFormat:@"%.2f", result]];
    }else if(isYenToDollar == NO){
        result = input * rate;
        [rateLabel setText:[NSString stringWithFormat:@"%.0f", result]];
    }
}

-(IBAction)changeCalcMethod:(id)sender
{
    if(selector.selectedSegmentIndex == 0){
        isYenToDollar = TRUE;
        [inputCurrency setText:@"円"];
        [resultCurrency setText:@"ドル"];
    }else if(selector.selectedSegmentIndex == 1){
        isYenToDollar = FALSE;
        [inputCurrency setText:@"ドル"];
        [resultCurrency setText:@"円"];
    }
    
    [self convert];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    input = [textField.text doubleValue];
    
    [textField resignFirstResponder];
    [self convert];
    
    return TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
