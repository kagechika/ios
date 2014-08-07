//
//  FavoritesViewController.h
//  WebBrowser
//
//  Created by okitokagechika on 2014/04/16.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "Favorites.h"

//delegateの宣言
@protocol FavoritesViewControllerDelegate;

@interface FavoritesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, FavoritesViewControllerDelegate>

@property id <FavoritesViewControllerDelegate> delegate;

@end

//独自のプロトコルを宣言
@protocol FavoritesViewControllerDelegate <NSObject>

-(void)favoritesViewControllerDidCancel: (FavoritesViewController *)controller;
-(void)favoritesViewControllerDidSelect: (FavoritesViewController *)controller withURL:(NSString *)favoriteUrl;

@end
