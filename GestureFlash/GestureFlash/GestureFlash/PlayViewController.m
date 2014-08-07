//
//  PlayViewController.m
//  GestureFlash
//
//  Created by okitokagechika on 2014/04/12.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()

@end

@implementation PlayViewController{
    //メンバー変数
    //ゲームの経過時間
    NSDate *startTime;
    //こなしたジェスチャー数
    int completedGestures;
    //現在のジェスチャー
    int currentGesture;
    
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *completedGesturesLabel;
    
    IBOutlet UIImageView *gestureImage;
    
    //経過時間の画面表示
    NSTimer *timer;
    double timerCount;
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
    
    completedGestures = 0;
    
    [self setGestureRecognizers];
    [self nextProblem];
    startTime = [NSDate date];
    
    //経過時間を表示するタイマー
    timerCount = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//結果表示画面へ
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //所要時間を計測
    NSTimeInterval elapsedTime = [startTime timeIntervalSinceNow];
    elapsedTime = -(elapsedTime);
    
    //ResultViewControllerのインスタンスを作成
    if ([[segue identifier] isEqualToString:@"toResultView"]) {
        ResultViewController *rvc = (ResultViewController*)[segue destinationViewController];
        rvc.time = elapsedTime;
    }
}

//次の問題を表示
-(void)nextProblem{
    if (completedGestures == 30) {
        //結果画面へ
        [self performSegueWithIdentifier:@"toResultView" sender:self];
        return;
    }
    
    UIImage *gestureIcons[8];
    gestureIcons[0] = [UIImage imageNamed:@"swipe-right.png"];
    gestureIcons[1] = [UIImage imageNamed:@"swipe-left.png"];
    gestureIcons[2] = [UIImage imageNamed:@"swipe-up.png"];
    gestureIcons[3] = [UIImage imageNamed:@"swipe-down.png"];
    gestureIcons[4] = [UIImage imageNamed:@"pinch-in.png"];
    gestureIcons[5] = [UIImage imageNamed:@"pinch-out.png"];
    gestureIcons[6] = [UIImage imageNamed:@"rotate-right.png"];
    gestureIcons[7] = [UIImage imageNamed:@"rotate-left.png"];
    
    srand((unsigned int)time(0));
    currentGesture = rand()%8;
    
    NSLog(@"got new gesture current: %d", currentGesture);
    
    gestureImage.image = gestureIcons[currentGesture];
    completedGesturesLabel.text = [NSString stringWithFormat:@"%d", completedGestures];
}

-(void)setGestureRecognizers{
    //Pinchの認識
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    [self .view addGestureRecognizer:pinchRecognizer];
    
    //Rotateの認識
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationDetected:)];
    [self.view addGestureRecognizer:rotationRecognizer];
    
    //右向きのSwipe認識
    UISwipeGestureRecognizer *swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightDetected:)];
    swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightRecognizer];
    
    //左向きのswipe認識
    UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftDetected:)];
    swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftRecognizer];
    
    //上向きのswipe認識
    UISwipeGestureRecognizer *swipeUpRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUpDetected:)];
    swipeUpRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpRecognizer];
    
    //下向きのswipe認識
    UISwipeGestureRecognizer *swipeDownRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownDetected:)];
    swipeDownRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDownRecognizer];
}

//右向きswipe
-(IBAction)swipeRightDetected:(UIGestureRecognizer *)sender{
    NSLog(@"右向きswipe");
    NSLog(@"current:%d",currentGesture);
    
    if (currentGesture == 0) {
        NSLog(@"NEXT");
        completedGestures++;
        [self nextProblem];
    }
}
//左向きswipe
-(IBAction)swipeLeftDetected:(UIGestureRecognizer *)sender{
    NSLog(@"左向きswipe");
    NSLog(@"current:%d",currentGesture);
    
    if (currentGesture == 1) {
        NSLog(@"NEXT");
        completedGestures++;
        [self nextProblem];
    }
}
//上向きswipe
-(IBAction)swipeUpDetected:(UIGestureRecognizer *)sender{
    NSLog(@"上向きswipe");
    NSLog(@"current:%d",currentGesture);
    
    if (currentGesture == 2) {
        NSLog(@"NEXT");
        completedGestures++;
        [self nextProblem];
    }
}
//下向きswipe
-(IBAction)swipeDownDetected:(UIGestureRecognizer *)sender{
    NSLog(@"下向きswipe");
    NSLog(@"current:%d",currentGesture);
    
    if (currentGesture == 3) {
        NSLog(@"NEXT");
        completedGestures++;
        [self nextProblem];
    }
}

//回転動作検出
-(IBAction)rotationDetected:(UIGestureRecognizer *)sender{
    //回転開始時からの回転の度合い
    CGFloat radians = [(UIRotationGestureRecognizer *)sender rotation];
    CGFloat degrees = radians*(180/M_PI);
    
    if (degrees > 90) {
        NSLog(@"時計周りにRotate degrees:%f", degrees);
        NSLog(@"current:%d",currentGesture);
        
        if (currentGesture == 6) {
            NSLog(@"next");
            completedGestures++;
            [self nextProblem];
        }
    } else if (degrees < -90) {
        NSLog(@"反時計周りにRotate degrees:%f", degrees);
        NSLog(@"current:%d",currentGesture);
        
        if (currentGesture == 7) {
            NSLog(@"next");
            completedGestures++;
            [self nextProblem];
        }
    }
}

//ピンチの検出
-(IBAction)pinchDetected:(UIGestureRecognizer *)sender{
    CGFloat scale = [(UIPinchGestureRecognizer *)sender scale];
    
    if (scale > 2.4) {
        NSLog(@"外向きにPinch scale:%f",scale);
        NSLog(@"current:%d", currentGesture);
        if (currentGesture == 5) {
            NSLog(@"next");
            completedGestures++;
            [self nextProblem];
        }
    } else if (scale < 0.4) {
        NSLog(@"内向きにPinch scale:%f",scale);
        NSLog(@"current:%d", currentGesture);
        if (currentGesture == 4) {
            NSLog(@"next");
            completedGestures++;
            [self nextProblem];
        }
    }
}

//0.1秒ごとに呼ばれる経過時間表示を更新
-(void)onTimer:(NSTimer *)timer{
    timerCount = timerCount + 0.1;
    timeLabel.text = [NSString stringWithFormat:@"%.1f", timerCount];
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
