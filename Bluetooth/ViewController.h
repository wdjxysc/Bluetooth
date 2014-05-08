//
//  ViewController.h
//  Bluetooth
//
//  Created by 夏 伟 on 13-5-7.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
@interface ViewController : UIViewController
{
    GKSession *currentSession;
    IBOutlet UITextField *txtMessage;
    IBOutlet UIButton *connect;
    IBOutlet UIButton *disconnect;
}
@property(nonatomic, retain) GKSession *currentSession;
@property(nonatomic, retain) UITextField *txtMessage;
@property(nonatomic, retain) UIButton *connect;
@property(nonatomic, retain) UIButton *disconnect;
-(IBAction) btnSend:(id) sender;
-(IBAction) btnConnect:(id) sender;
-(IBAction) btnDisconnect:(id) sender;
@end
