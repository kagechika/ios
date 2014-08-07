//
//  ViewController.m
//  ToyCamera
//
//  Created by okitokagechika on 2014/05/18.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    IBOutlet UIImageView *aImageView;
}

-(IBAction)doCamera:(id)sender{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return;
    }
    
    // カメラを起動する
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    [ipc setSourceType:sourceType];
    [ipc setDelegate:self];
    [ipc setAllowsEditing:YES];
    [self presentViewController:ipc animated:YES completion:^{
        // ステータスバーを隠す
        [UIApplication sharedApplication].statusBarHidden = YES;
    }];
}

-(IBAction)doFilter:(id)sender{
    // アクションシートを表示
    UIActionSheet *aSheet = [[UIActionSheet alloc] initWithTitle:@"フィルター選択" delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:nil otherButtonTitles:@"セピア", @"ボタン2", @"ボタン3", nil];
    [aSheet setActionSheetStyle:UIActionSheetStyleDefault];
    [aSheet showInView:[self view]];
}

-(IBAction)doSave:(id)sender{
    UIImage *aImage = [aImageView image];
    if (aImage == nil) {
        return;
    }
    
    UIImageWriteToSavedPhotosAlbum(aImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

// 撮影画面表示時に呼ばれるメソッド
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}

// 撮影画面表示時に呼ばれるメソッド
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{

}

// 撮影完了時に呼ばれるメソッド
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *aImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [aImageView setImage:aImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        // ステータスバーを表示する
        [UIApplication sharedApplication].statusBarHidden = NO;
    }];
}

// 撮影キャンセル時に呼ばれるメソッド
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        // ステータスバーを表示する
        [UIApplication sharedApplication].statusBarHidden = NO;
    }];
}

// アクションシートのボタンをクリックされた時に呼ばれるメソッド
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    // ボタン1
    if (buttonIndex == 0) {
        NSLog(@"1");
        [self toSepia];
    
    } else if (buttonIndex == 1){
        NSLog(@"2");
        
    } else if (buttonIndex == 2){
        NSLog(@"3");
    
    } else {
        NSLog(@"4");
    }
}

// セピア変換
-(void)toSepia{
    UIImage *orgImage = [aImageView image];
    if (orgImage == nil) {
        return;
    }
    
    // CIImageの作成
    CIImage *ciImage = [[CIImage alloc] initWithImage:orgImage];
    
    // CIFilterの作成
    CIFilter *ciFilter = [  CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, ciImage, @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    
    // セピアフィルタをかけた画像をImageViewに格納
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgImgRef = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgImgRef scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgImgRef);
    [aImageView setImage:newImage];
    
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"保存完了");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存終了" message:@"アルバムに画像を保存しました。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
