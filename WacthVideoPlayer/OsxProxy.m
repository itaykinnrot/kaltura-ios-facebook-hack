//
//  OsxProxy.m
//  WacthVideoPlayer
//
//  Created by Eliza Sapir on 8/6/15.
//  Copyright © 2015 kaltura. All rights reserved.
//

#import "OsxProxy.h"
@import MultipeerConnectivity;

static NSString *kServiceType = @"iosToOsx";

@interface OsxProxy () <MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate, MCSessionDelegate>

@property MCSession *session;
@property MCPeerID *ownPeer;
@property MCNearbyServiceAdvertiser *advertiser;
@property MCNearbyServiceBrowser *browser;

@property NSMutableArray *peers;

@end

@implementation OsxProxy

- (instancetype)init {
    self = [super init];
    if (self) {
        self.ownPeer = [[MCPeerID alloc] initWithDisplayName:UIDevice.currentDevice.name];
        self.session = [[MCSession alloc] initWithPeer:self.ownPeer];
        self.session.delegate = self;
        self.advertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.ownPeer discoveryInfo:@{} serviceType:kServiceType];
        self.advertiser.delegate = self;
        self.browser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.ownPeer serviceType:kServiceType];
        self.browser.delegate = self;
        
        self.peers = [NSMutableArray array];
    }
    return self;
}

- (void)start {
    [self.advertiser startAdvertisingPeer];
    [self.browser startBrowsingForPeers];
}

#pragma mark - Advertiser delegates

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didNotStartAdvertisingPeer:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession *))invitationHandler {
    invitationHandler(YES, self.session);
}

#pragma mark - Browser delegates

- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
    NSLog(@"Discovered %@: %@", peerID.displayName, info);
    
    [self.browser invitePeer:peerID toSession:self.session withContext:nil timeout:0];
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID {
    NSLog(@"Lost %@", peerID.displayName);
}

#pragma mark - Session delegates

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
#if 0
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Received data: %@", str);
#endif
    
    NSObject *object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"Received object %@", object);
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
}

- (void)sendData:(NSData *)data {
    NSError *error;
    if (![self.session sendData:data toPeers:self.peers withMode:MCSessionSendDataReliable error:&error]) {
        NSLog(@"%@", error);
    }
}

- (void)sendString:(NSString *)string {
    [self sendData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    switch (state) {
        case MCSessionStateConnecting:
            NSLog(@"%@ connecting", peerID);
            break;
        case MCSessionStateConnected:
            NSLog(@"%@ connected", peerID);
            [self.peers addObject:peerID];
            [self.delegate peerConnected];
            break;
        case MCSessionStateNotConnected:
            NSLog(@"%@ disconnected", peerID);
            [self.peers removeObject:peerID];
            break;
    }
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
}

@end
