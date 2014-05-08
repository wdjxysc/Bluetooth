//
//  ViewController.m
//  Bluetooth
//
//  Created by 夏 伟 on 13-5-7.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize currentSession;
@synthesize txtMessage;
@synthesize connect;
@synthesize disconnect;
GKPeerPickerController *picker;
- (void)viewDidLoad
{
    [connect setHidden:NO];
    [disconnect setHidden:YES];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) btnConnect:(id) sender
{
    picker =[[GKPeerPickerController alloc] init];
    picker.delegate =self;
    picker.connectionTypesMask =GKPeerPickerConnectionTypeNearby;
    [connect setHidden:YES];
    [disconnect setHidden:NO];
    [picker show];
}

-(void)peerPickerController:(GKPeerPickerController *)picker
             didConnectPeer:(NSString *)peerID
                  toSession:(GKSession *) session {
    self.currentSession =session;
    session.delegate =self;
    [session setDataReceiveHandler:self withContext:nil];
    picker.delegate =nil;
    [picker dismiss];
}

-(void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    picker.delegate =nil;
    [connect setHidden:NO];
    [disconnect setHidden:YES];
}

-(IBAction) btnDisconnect:(id) sender
{
    [self.currentSession disconnectFromAllPeers];
    currentSession =nil;
    [connect setHidden:NO];
    [disconnect setHidden:YES];
}

-(void)session:(GKSession *)session
          peer:(NSString *)peerID
didChangeState:(GKPeerConnectionState)state
{
    switch (state)
    {
        caseGKPeerStateConnected:
            NSLog(@"connected");
            break;
        caseGKPeerStateDisconnected:
            NSLog(@"disconnected");
            currentSession =nil;
            [connect setHidden:NO];
            [disconnect setHidden:YES];
            break;
    }
}

-(void) mySendDataToPeers:(NSData *) data
{
    if(currentSession)
        [self.currentSession sendDataToAllPeers:data
                                   withDataMode:GKSendDataReliable
                                          error:nil];
}

-(IBAction) btnSend:(id) sender
{
    //---convert an NSString objecttoNSData---22 23
    NSData *data;
    NSString *str =[NSString stringWithString:txtMessage.text];
    data =[str dataUsingEncoding: NSASCIIStringEncoding];
    [self mySendDataToPeers:data];
}

-(void) receiveData:(NSData *)data
           fromPeer:(NSString *)peer
          inSession:(GKSession *)session
            context:(void *)context
{
    //---convert the NSData toNSString---10 11
    NSString *str;
    str =[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Data received" message:str
                                                  delegate:self
                                         cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
