//
//  ListTVCTableViewController.m
//  Para2Camera
//
//  Created by okitokagechika on 2014/05/24.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "ListTVCTableViewController.h"

@interface ListTVCTableViewController ()

@end

@implementation ListTVCTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //ステータスバーを隠す
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    // テーブルビューの高さを指定
    [[self tableView] setRowHeight:57.0f];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // テーブルビューをリロードする
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return kParaParaCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    [[cell textLabel] setText:[NSString stringWithFormat:@"%d 番目", (int)[indexPath row]]];
    
    // iconに"no_image.png"をセットする
    UIImage *iconImage = [UIImage imageNamed:@"no_image.png"];
    // セル番号を引数にして、アイコンのファイルパスを生成する
    NSString *iconFilePath = [self makeIconPathWithIndex:[indexPath row]];
    // アイコンのファイルパスが存在している場合
    if ([[NSFileManager defaultManager] fileExistsAtPath:iconFilePath] == YES) {
        // 指定したファイルパスのイメージをロードしてイメージオブジェクトを作成する
        iconImage = [UIImage imageWithContentsOfFile:iconFilePath];
    }
    // セルにアイコンイメージを表示させる
    [[cell imageView] setImage:iconImage];
    
    return cell;
}

// セルがタップされたときに呼ばれるメソッド
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //セル番号を格納するメソッド
    indexRow = [indexPath row];
    //写真関係を取り扱うコントローラの初期化
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    // もしカメラが有効の場合
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // カメラから画像を取得する
        [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        // カメラが有効でない場合
        [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    // デリゲートをセットする
    [ipc setDelegate:self];
    // 編集を可能にする
    [ipc setAllowsEditing:YES];
    // imagePickerControllerをモーダルとして呼び出す
    [self presentViewController:ipc animated:YES completion:nil];
    // テーブルビューのセルの選択状態を解除する
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 撮影が終了したときに呼ばれるメソッド
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    // 編集後写真の取り出し
    UIImage *aImage = [info objectForKey:UIImagePickerControllerEditedImage];
    // 撮影した画像をJPEG形式で保存する
    NSString *photoFilePath = [ListTVCTableViewController makePhotoPathWithIndex:indexRow];
    [UIImageJPEGRepresentation(aImage, 0.7f) writeToFile:photoFilePath atomically:YES];
    // 呼び出された画面をアニメーションしながら閉じる
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // アイコンの作成
    // アイコンのファイルパスを取得
    NSString *iconFilePath = [self makeIconPathWithIndex:indexRow];
    // アイコンを表示させるサイズを指定
    CGSize size = CGSizeMake(57.0f, 57.0f);
    // 画像を指定したサイズにリサイズする処理
    UIGraphicsBeginImageContext(size);
    [aImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    UIImage *imageIcon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // リサイズされた画像をPNG形式で保存する
    [UIImagePNGRepresentation(imageIcon) writeToFile:iconFilePath atomically:YES];
    
    // 呼び出された画面をアニメーションを付けながら閉じる
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

// 撮影後にキャンセルしたときに呼ばれるメソッド
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// ファイル名を組み立てるメソッド
+(NSString *)makePhotoPathWithIndex:(NSInteger)idx{
    // ホームディレクトリに"Dictionary"という名前のディレクトリを設定
    NSString *docFolder = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // 保存先を"Dictionary"にし、セル番号を引数にして画像を保存
    NSString *photoFilePath = [NSString stringWithFormat:@"%@/photo-%04d.jpg", docFolder, idx];
    
    return photoFilePath;
}

// アイコンのファイル名を組み立てるメソッド
-(NSString *)makeIconPathWithIndex:(NSInteger)idx{
    // ホームディレクトリに"Dictionary"という名前のディレクトリを設定
    NSString *docFolder = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //保存先を"Dictionary"にし、セル番号を引数にして画像を保存
    NSString *iconFilePath = [NSString stringWithFormat:@"%@/icon-%04d.png", docFolder, idx];
    
    return iconFilePath;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
