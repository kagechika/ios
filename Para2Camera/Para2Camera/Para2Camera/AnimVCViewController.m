//
//  AnimVCViewController.m
//  Para2Camera
//
//  Created by okitokagechika on 2014/05/24.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "AnimVCViewController.h"
#import "ListTVCTableViewController.h"

@interface AnimVCViewController ()

@end

@implementation AnimVCViewController

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
    
    //ステータスバーを隠す
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// スライダーの値を取得するメソッド
-(IBAction)doSliderValueChanged:(id)sender{
    // ImageViewにおけるアニメーションの再生状態を取得する
    BOOL isAnimating = [_aImageView isAnimating];
    // スライダーの変更値を引数にして、ImageViewのアニメーションの速度を設定する
    [_aImageView setAnimationDuration:[_aSlider value]];
    // もしアニメーションが再生以外のとき
    if (isAnimating == NO) {
        // アニメーションをスタートさせる
        [_aImageView startAnimating];
    }
}

//イメージをセットする処理
-(void)setImages{
    // 編集可能な配列を作成
    NSMutableArray *array = [NSMutableArray array];
    // 0からkParaParaCount(10)まで連続して以下の処理を行う
    for (int i=0; i<kParaParaCount; i++) {
        // ListTVCで生成した画像のファイルパスを取得する
        NSString *photoFilePath = [ListTVCTableViewController makePhotoPathWithIndex:i];
        // もしファイルパスが存在する場合
        if ([[NSFileManager defaultManager] fileExistsAtPath:photoFilePath] == YES) {
            // 指定したファイルパスのイメージをロードしてイメージオブジェクトを作成する
            UIImage *image = [UIImage imageWithContentsOfFile:photoFilePath];
            // 配列に格納する
            [array addObject:image];
            // imageViewに画像がない
            if ([_aImageView image] == nil) {
                // ImageViewに画像をセットする
                [_aImageView setImage:image];
            }
        }
    }
    
    // 配列に格納されている画像にアニメーションを設定する
    [_aImageView setAnimationImages:array];
    // スライダーの設定値を引数にしてアニメーションの速度をあげる
    [_aImageView setAnimationDuration:[_aSlider value]];
}

// 画面が現れたときに呼ばれるメソッド
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // イメージをリセットするメソッドを呼ぶ
    [self setImages];
}

// 画面にタッチされたときに呼ばれるメソッド
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // タッチ判別用
    UITouch *touch = [touches anyObject];
    // 自分のビューの中でタッチされた座標を取得する
    CGPoint pos = [touch locationInView:[self view]];
    // もしタッチされた位置（第二引数:pos）が、
    // ImageViewの枠内（第一引数:frame）の範囲内の場合
    if (CGRectContainsPoint([_aImageView frame], pos)) {
        // アニメーションが発生している場合
        if ([_aImageView isAnimating]) {
            // アニメーションを停止する
            [_aImageView stopAnimating];
        } else {
            // アニメーションをスタートする
            [_aImageView startAnimating];
        }
    }
}

// 画面が非表示になったときに呼ばれるメソッド
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // ImageViewのアニメーションをストップする
    [_aImageView stopAnimating];
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
