//
//  Clap.h
//  ClapBeat
//
//  Created by okitokagechika on 2014/04/06.
//
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Clap : NSObject

+(id)initClap;
-(void)repeatClap:(int)count;

@end
