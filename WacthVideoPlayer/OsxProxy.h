//
//  OsxProxy.h
//  WacthVideoPlayer
//
//  Created by Eliza Sapir on 8/6/15.
//  Copyright © 2015 kaltura. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OsxProxyDelegate

- (void)peerConnected;
- (void)peerDisconnected;

@end

@interface OsxProxy : NSObject

- (instancetype)init;

- (void)start;

- (void)sendData:(NSData *)data;
- (void)sendString:(NSString *)string;
- (void)sendDictionary:(NSDictionary *)dictionary;
- (void)disconnectLocalPeer;

@property (weak) id<OsxProxyDelegate> delegate;

@end
