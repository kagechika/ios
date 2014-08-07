//
//  TapViewController.m
//  TapApp
//
//  Created by okitokagechika on 2014/05/11.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "TapViewController.h"

@interface TapViewController ()

@end

@implementation TapViewController{
    //ゲームの経過時間
    NSDate *startTime;
    //経過時間の画面表示
    NSTimer *timer;
    double timerCount;
    
    IBOutlet UILabel *timerLabel;
    int counter;
    IBOutlet UILabel *counterLabel;
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
    
    startTime = [NSDate date];
    
    //経過時間を表示するタイマー
    timerCount = 20;
    timerLabel.text = [NSString stringWithFormat:@"%.1f", timerCount];
    counter = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)tapCount:(id)sender{
    if(counter == 0){
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    }
    
    counter++;
    counterLabel.text = [NSString stringWithFormat:@"%d", counter];
}

//0.1秒ごとに呼ばれる経過時間表示を更新
-(void)onTimer:(NSTimer *)timer{
    
    if (timerCount <= 0) {
        timerCount = 20;
        //結果画面へ
        [self performSegueWithIdentifier:@"toResultView" sender:self];
        return;
    }else{
        timerCount = timerCount - 0.1;
        timerLabel.text = [NSString stringWithFormat:@"%.1f", timerCount];
    }
    
}

//結果表示画面へ
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //ResultViewControllerのインスタンスを作成
    if ([[segue identifier] isEqualToString:@"toResultView"]) {
        ResultViewController *rvc = (ResultViewController*)[segue destinationViewController];
        rvc.counter = counter;
    }
}

@end
