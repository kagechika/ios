//
//  SettingViewController.h
//  MyAlarm
//
//  Created by okitokagechika on 2014/05/17.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import <UIKit/UIKit.h>

// delegate用のプロトコルを宣言
@protocol SettingViewControllerDelegate;

// クラスを設定する
@interface SettingViewController : UIViewController

// 他クラスから参照させるためのプロパティの設定
@property id<SettingViewControllerDelegate> delegate;

// ピッカーの名前用
@property NSString *pickerName;

// 時刻設定用
@property NSDate *dispDate;

@end

// delegate用のプロトコルを設定
@protocol SettingViewControllerDelegate

// Saveボタンが押されたときに呼び出すメソッド
-(void)didSaveButtonClicked:(SettingViewController *)controller selectedDate:(NSDate *)selectedDate pickerName:(NSString *)pickerName;

// キャンセルボタンが押されたときに呼び出すメソッド
-(void)didCancelButtonClicked:(SettingViewController *)controller pickerName:(NSString *)pickerName;

// refreshボタンが押されたときに呼び出すメソッド
-(void)didRefreshButtonClicked:(SettingViewController *)controller pickerName:(NSString *)pickerName;


@end
