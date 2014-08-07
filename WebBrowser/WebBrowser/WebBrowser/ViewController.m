//
//  ViewController.m
//  WebBrowser
//
//  Created by okitokagechika on 2014/04/16.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    IBOutlet UIWebView *webView;
    IBOutlet UITextField *urlField;
    
    NSString *pageTitle;
    NSString *url;
    
    BOOL loadSuccessful;
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
    
    url = @"http://www.google.co.jp";
    [self makeRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ページを要求・表示
-(void)makeRequest{
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSLog(@"%@", [NSURL URLWithString:url]);
    
    [webView loadRequest:urlReq];
    
    //処理が完了するまでloadSuccessfulをfalse
    loadSuccessful = false;
    
    //Activity Indicator発動
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

//webロードが正常に完了
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //ロードしたページと名前とURLを表示
    url = [[webView.request URL] absoluteString];
    pageTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //現在のURLをアドレスバーに反映
    urlField.text = url;
    
    //ステータスバーのActivity Indicatorの停止
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //処理が完了したのでloadSuccessfulをtrueに
    loadSuccessful = true;
}

//web viewロード中にエラーが生じた場合
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //ステータスバーのActivity Indicatorを停止
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (([[error domain] isEqual:NSURLErrorDomain]) && ([error code]!=NSURLErrorCancelled)) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = @"エラー";
        alert.message = [NSString stringWithFormat:@"「%@」をロードするのに失敗しました", url];
        [alert addButtonWithTitle:@"OK"];
        [alert show];
    }
}

//UITextFieldのキーボード上のReturnが押されたときの処理
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //キーボードの入力値を取得
    NSString *keyboardInput = textField.text;
    
    //httpはじまりか
    if (![keyboardInput hasPrefix:@"http://"]) {
        NSString *prefix = @"http://";
        url = [prefix stringByAppendingString:keyboardInput];
        textField.text = url;
    } else {
        url = keyboardInput;
    }
    
    //キーボードを閉じる
    [textField resignFirstResponder];
    
    //指定されたページをロード
    [self makeRequest];
    
    return TRUE;
}

//お気に入りボタン押下
-(IBAction)saveFavorite:(id)sender{
    //新しいページをロード中はお気に入り登録を禁止
    if (loadSuccessful == false) {
        //エラーメッセージ
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = @"エラー";
        alert.message = @"正常にロードされていません";
        [alert addButtonWithTitle:@"OK"];
        [alert show];
        return;
    }
    
    [self insertNewObject];
    
    //メッセージを表示
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"お気に入り登録完了";
    alert.message = [NSString stringWithFormat:@"「%@」を登録しました。", pageTitle];
    [alert addButtonWithTitle:@"OK"];
    [alert show];
}

//DBに登録する
-(void)insertNewObject{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    //保存する情報を用意
    NSManagedObject *newManageObject = [NSEntityDescription insertNewObjectForEntityForName:@"MyFavorites" inManagedObjectContext:context];
    [newManageObject setValue:pageTitle forKeyPath:@"title"];
    [newManageObject setValue:url forKeyPath:@"url"];
    
    //保存を実行
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"エラーが発生しました: %@ %@", error, [error userInfo]);
        abort();
    }
}

-(IBAction)goToFavorites:(id)sender{
    //お気に入り画面へ
    [self performSegueWithIdentifier:@"toFavoritesView" sender:self];
}

//お気に入りのsegue発動
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toFavoritesView"]) {
        FavoritesViewController *fvc = (FavoritesViewController *)[segue destinationViewController];
        fvc.delegate = (id)self;
    }
}

//Favoritesリストの戻るが押されたとき
-(void)favoritesViewControllerDidCancel:(FavoritesViewController *)controller{
    //FavoriteViewControllerを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Favoritesリストで選択されたとき
-(void)favoritesViewControllerDidSelect:(FavoritesViewController *)controller withURL:(NSString *)favoriteUrl{
    //セレクトされたURLをロード
    url = favoriteUrl;
    [self makeRequest];
    
    //FavoriteViewControllerを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
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
