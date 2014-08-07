//
//  SecondViewController.m
//  SwipeApp
//
//  Created by okitokagechika on 2014/05/25.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController{
    IBOutlet UIButton *button;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buttonTrigger:0];
    [self setGestureRecognizers];
}

-(void)buttonTrigger:(int)direction{
    
    if (direction == 1) {
        button.hidden = NO;
    } else {
        button.hidden = YES;
    }
}

-(void)setGestureRecognizers{
    //Pinchの認識
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    [self .view addGestureRecognizer:pinchRecognizer];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
