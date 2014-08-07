//
//  QuizViewController.m
//  Quiz
//
//  Created by okitokagechika on 2014/04/11.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "QuizViewController.h"
#import "Problem.h"

@interface QuizViewController () {
    //問題文の格納配列
    NSMutableArray *problemSet;
    //出題問題数
    int totalProblems;
    //回答済み問題数
    int currentProblem;
    //正解数
    int correctAnswers;
    
    IBOutlet UITextView *problemText;
}

@end

@implementation QuizViewController

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
    
    [self loadProblemet];
    [self shuffleProblemSet];
    
    totalProblems = 10;
    currentProblem  = 0;
    correctAnswers = 0;
    
    problemText.text = [[problemSet objectAtIndex:currentProblem] getQ];
}

//問題文の読み込み
-(void)loadProblemet{
    //ファイルの読み込み
    NSString *path = [[NSBundle mainBundle] pathForResource:@"quiz" ofType:@"csv"];
    NSError *error = nil;
    int enc = NSUTF8StringEncoding;
    NSString *text = [NSString stringWithContentsOfFile:path encoding:enc error:&error];
    
    //行ごと分割し、配列に格納
    NSArray *lines = [text componentsSeparatedByString:@"\n"];
    
    problemSet = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[lines count]; i++) {
        //問題文をカンマで区切る
        NSArray *items = [[lines objectAtIndex:i] componentsSeparatedByString:@","];
        //Problemクラスに問題文、解答を格納
        Problem *p = [Problem initProblem];
        NSString *q = [items objectAtIndex:0];
        int a = [[items objectAtIndex:1] intValue];
        [p setQ:q withA:a];
        
        //新たに生成したProblemクラスのインスタンスをproblemSetに追加
        [problemSet addObject:p];
    }
}

//問題文をシャッフル
-(void)shuffleProblemSet{
    // problemSetの全問題数を取得
    int totalQuestions = (int)[problemSet count];
    int i = totalQuestions;
    
    while (i > 0) {
        srand((unsigned int)time(0));
        int j = rand()%i;
        
        //要素を並び替え
        [problemSet exchangeObjectAtIndex:(i-1) withObjectAtIndex:j];
        i=i-1;
    }
}

-(void)nextProblem{
    currentProblem++;
    if(currentProblem < totalProblems){
        //次の問題を表示
        problemText.text = [[problemSet objectAtIndex:currentProblem] getQ];
    }else{
        //結果表示画面へ
        [self performSegueWithIdentifier:@"toResultView" sender:self];
    }
    
}

//結果表示画面へ(次画面への引き継ぎ)
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //正解率を算出
    int percentage = correctAnswers*100/totalProblems;
    //ResultViewContorollerのインスタンス作成
    if([[segue identifier] isEqualToString:@"toResultView"]){
        ResultViewController *rvc = (ResultViewController*)[segue destinationViewController];
        rvc.correctPercentage = percentage;
    }
}

-(IBAction)answerlsTrue:(id)sender{
    if ([[problemSet objectAtIndex:currentProblem] getA] == 0) {
        correctAnswers++;
    }
    
    [self nextProblem];
}

-(IBAction)answerlsFalse:(id)sender{
    if ([[problemSet objectAtIndex:currentProblem] getA] == 1) {
        correctAnswers++;
    }
    
    [self nextProblem];
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
