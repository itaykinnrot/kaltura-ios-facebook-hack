//
//  InterfaceController.m
//  WacthVideoPlayer WatchKit Extension
//
//  Created by Nissim Pardo on 8/5/15.
//  Copyright © 2015 kaltura. All rights reserved.
//

@import WatchConnectivity;
#import "InterfaceController.h"


@interface InterfaceController() <WCSessionDelegate> {
    NSDictionary *params;
}
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *picker;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *trailerButton;

@end


@implementation InterfaceController

NSInteger _selectedItem;
NSArray *_movies;

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [WCSession defaultSession].delegate = self;
        [[WCSession defaultSession] activateSession];
    }
    
    return self;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    _movies = @[@{@"name": @"Cloudy", @"url": @"http://bit.ly/1EaWkxi"},
  @{@"name": @"Frozen", @"url": @"http://bit.ly/1M7WWdv"},
  @{@"name": @"Inside Out", @"url": @"http://bit.ly/1gMEdsJ"}];
    WKPickerItem *item1 = [self createPickerItemWithImageName:@"Cloudy" andExtension:@"jpg" andCaption:@"Movie1"];
    //    [item1 setTitle:@"hello"];
    WKPickerItem *item2 = [self createPickerItemWithImageName:@"Frozen" andExtension:@"jpg" andCaption:@"Movie2"];
    WKPickerItem *item3 = [self createPickerItemWithImageName:@"Inside" andExtension:@"jpg" andCaption:@"Movie3"];
    [self setButtonTitleWithIndex:0];
    [_picker setItems:@[item1, item2, item3]];
    [_picker setEnabled:YES];

}

- (IBAction)TapButton {
    [self setupMovieTrailerForItem:_selectedItem];
}

- (IBAction)Tocuh:(NSInteger)value {
    NSLog(@"%d",value);
    _selectedItem = value;
    [self setButtonTitleWithIndex:_selectedItem];
    //    [self pushControllerWithName:@"PlayerController" context:nil];
    
}

- (void)setButtonTitleWithIndex:(NSInteger) value
{
    [_trailerButton setTitle:_movies[value][@"name"]];
}


- (WKPickerItem *) createPickerItemWithImageName:(NSString *)imgname andExtension:(NSString *)imgExtension andCaption:(NSString *)caption
{
    WKPickerItem *item = [[WKPickerItem alloc] init];
    //        [item setTitle:@"hello"];
    //    [item setCaption:caption];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imgname withExtension:imgExtension];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [item setContentImage:[WKImage imageWithImageData:data]];
    return item;
}

- (void) setupMovieTrailerForItem:(NSInteger)value {
    [self presentControllerWithName:@"player" context:_movies[value]];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"mvcarchitecture" withExtension:@"mp4"];
//    [self.player setMovieURL:url];
//    [self presentMediaPlayerControllerWithURL:url options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
//        
//    }];
}

- (IBAction)teleport:(id)sender
{
    WCSession *session = [WCSession defaultSession];
    
    if ([session isReachable])
    {
        NSDictionary *dictionary = @{ @"TextInput": @"1"};

        [[WCSession defaultSession] sendMessage:dictionary replyHandler:^(NSDictionary<NSString *,id> * __nonnull replyMessage) {
            NSLog(@"Reply Info: %@", replyMessage);
        } errorHandler:^(NSError * __nonnull error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        }];
    }
    else
    {
        NSLog(@"session not reachable");
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



