//
//  InterfaceController.m
//  WacthVideoPlayer WatchKit Extension
//
//  Created by Nissim Pardo on 8/5/15.
//  Copyright © 2015 kaltura. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceMovie *player;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *picker;

@end


@implementation InterfaceController

NSInteger _selectedItem;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    WKPickerItem *item1 = [self createPickerItemWithImageName:@"movie1" andExtension:@"png" andCaption:@"Movie1"];
//    [item1 setTitle:@"hello"];
    WKPickerItem *item2 = [self createPickerItemWithImageName:@"movie2" andExtension:@"gif" andCaption:@"Movie2"];
    WKPickerItem *item3 = [self createPickerItemWithImageName:@"movie3" andExtension:@"png" andCaption:@"Movie3"];
    
    [_picker setItems:@[item1, item2, item3]];
    [_picker setEnabled:YES];

    // Configure interface objects here.
}
- (IBAction)TapButton {
    [self setupMovieTrailerForItem:_selectedItem];
}

- (IBAction)Tocuh:(NSInteger)value {
    NSLog(@"%d",value);
    _selectedItem = value;
//    [self pushControllerWithName:@"PlayerController" context:nil];
    
}

- (WKPickerItem *) createPickerItemWithImageName:(NSString *)imgname andExtension:(NSString *)imgExtension andCaption:(NSString *)caption
{
    WKPickerItem *item = [[WKPickerItem alloc] init];
//        [item setTitle:@"hello"];
    [item setCaption:caption];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imgname withExtension:imgExtension];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [item setContentImage:[WKImage imageWithImageData:data]];
    return item;
}

- (void) setupMovieTrailerForItem:(NSInteger)value {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"mvcarchitecture" withExtension:@"mp4"];
    [self.player setMovieURL:url];
    [self presentMediaPlayerControllerWithURL:url options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
        
    }];
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



