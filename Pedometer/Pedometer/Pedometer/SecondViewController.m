//
//  SecondViewController.m
//  Pedometer
//
//  Created by okitokagechika on 2014/04/27.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController{
    //Location Manager
    CLLocationManager *locationManager;
    //緯度と経度のラベル
    IBOutlet UILabel *longitudeLabel;
    IBOutlet UILabel *latitudeLabel;
    //位置情報の精度を示すラベル
    IBOutlet UILabel *accuracyLabel;
    //Map View
    IBOutlet MKMapView *map;
    //Map Viewに表示するエリアを定義するMKCoordinateRegion
    MKCoordinateRegion region;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //位置情報取得準備
    [self initLocation];
    //地図を初期化
    [self initMapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMapView{
    //地図上に現在地マーカーを表示
    map.showsUserLocation = YES;
    //最初の中心点を東京タワーに設置
    region.center.latitude = 35.658609;
    region.center.longitude = 139.745447;
    //ズームの設定
    region.span.latitudeDelta = 0.005;
    region.span.longitudeDelta = 0.005;
    //地図の中心を移動
    [map setRegion:region animated:YES];
}

-(void)initLocation{
    //Location Managerを作成
    locationManager = [[CLLocationManager alloc] init];
    //Location Managerの設定
    locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //位置情報の取得
    [locationManager startUpdatingLocation];
}

//位置情報が更新された時に呼ばれる
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //ラベルを更新
    longitudeLabel.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    latitudeLabel.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    //誤差値
    int accuracy = newLocation.horizontalAccuracy;
    
    if (accuracy < 15) {
        accuracyLabel.text = [NSString stringWithFormat:@"高 (%d m)", accuracy];
    } else {
        accuracyLabel.text = [NSString stringWithFormat:@"低 (%d m)", accuracy];
    }
    //現在地が移動したら、地図も追従
    region.center = newLocation.coordinate;
    [map setRegion:region animated:YES];
}

//位置取得失敗時に呼ばれる
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    //エラーに応じてUIAlertを提示
    if (error) {
        NSString *message = nil;
        if ([error code] == kCLErrorDenied) {
            [locationManager stopUpdatingLocation];
            message = [NSString stringWithFormat:@"このアプリは位置情報サービスが許可されていません。"];
        } else {
            message = [NSString stringWithFormat:@"位置情報の取得に失敗しました。"];
        }
        
        if (message != nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

@end
