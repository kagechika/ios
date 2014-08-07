//
//  Contact.h
//  QRContact
//
//  Created by okitokagechika on 2014/05/11.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property NSString *lastname;
@property NSString *firstname;
@property NSString *lastyomi;
@property NSString *firstyomi;
@property NSMutableArray *email;
@property NSMutableArray *phone;

@end
