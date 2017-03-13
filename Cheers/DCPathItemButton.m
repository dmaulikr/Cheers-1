//
//  DCPathItemButton.m
//  DCPathButton
//
//  Created by tang dixi on 31/7/14.
//  Copyright (c) 2014 Tangdxi. All rights reserved.
//

#import "DCPathItemButton.h"

@interface DCPathItemButton ()

@end

@implementation DCPathItemButton

- (instancetype)initWithImage:(UIImage *)image
             imageMain:(UIImage *)imageMain
             color:(UIColor *)color
{
    if (self = [super init]) {
        
        // Make sure the iteam has a certain frame
        //
        CGRect itemFrame = CGRectMake(0, 0, image.size.width, image.size.height);
        self.frame = itemFrame;
        
        // Configure the item's image
        //
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateHighlighted];
        
        // Configure background
        //
        _backgroundImageView = [[UIImageView alloc]initWithImage:image
                                                highlightedImage:image];
        _itemImage = imageMain;
        _itemColor = color;
        _backgroundImageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        
        [self addSubview:_backgroundImageView];
        
        // Add an action for the item button
        //
        [self addTarget:_delegate action:@selector(itemButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

@end
