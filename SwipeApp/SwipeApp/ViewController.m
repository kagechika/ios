//
//  ViewController.m
//  SwipeApp
//
//  Created by okitokagechika on 2014/05/25.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController {

    NSString *input;
    
    IBOutlet UIButton *button;
    
    // segmented controlのインスタンス
    IBOutlet UISegmentedControl *selector;
    IBOutlet UITextField *inputField;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // inputFieldのDelegate通知をViewControllerで受け取る
    inputField.delegate = self;

    [self buttonTrigger:0];
    [self setGestureRecognizers];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    input = textField.text;
    [textField resignFirstResponder];
    
    return TRUE;
}

-(void)buttonTrigger:(int)direction{
    
    if (direction == 1) {
        button.hidden = NO;
    } else {
        button.hidden = YES;
    }
}

-(void)textTrigger:(NSString *)text direction:(int)direction{
    if (direction == 1) {
        inputField.text = @"";
    } else {
        inputField.text = text;
    }
}

-(void)setGestureRecognizers{
    //Pinchの認識
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    [self .view addGestureRecognizer:pinchRecognizer];
    
    //上向きのswipe認識
    UISwipeGestureRecognizer *swipeUpRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUpDetected:)];
    swipeUpRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpRecognizer];
    
    //下向きのswipe認識
    UISwipeGestureRecognizer *swipeDownRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownDetected:)];
    swipeDownRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDownRecognizer];
}

//上向きswipe
-(IBAction)swipeUpDetected:(UIGestureRecognizer *)sender{
    [self textTrigger:input direction:0];
}
//下向きswipe
-(IBAction)swipeDownDetected:(UIGestureRecognizer *)sender{
    [self textTrigger:input direction:1];
}
//ピンチの検出
-(IBAction)pinchDetected:(UIGestureRecognizer *)sender{
    CGFloat scale = [(UIPinchGestureRecognizer *)sender scale];
    
    if (scale > 2.4) {
        [self buttonTrigger:0];
        
    } else if (scale < 0.4) {
        [self buttonTrigger:1];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
