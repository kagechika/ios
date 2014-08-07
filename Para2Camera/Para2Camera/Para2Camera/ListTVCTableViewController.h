//
//  ListTVCTableViewController.h
//  Para2Camera
//
//  Created by okitokagechika on 2014/05/24.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import <UIKit/UIKit.h>

// パラパラ漫画の枚数を指定する
#define kParaParaCount 10

@interface ListTVCTableViewController : UITableViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    // カメラの起動の元になったセル番号
    NSInteger indexRow;
}

// ファイル名を組み立てるメソッド
+(NSString *)makePhotoPathWithIndex:(NSInteger)idx;

@end
