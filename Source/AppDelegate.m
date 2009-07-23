//
//  AppDelegate.m
//  RaisedEditor2
//
//  Created by Andy Kim on 1/29/08.
//  Copyright 2008 Potion Factory LLC. All rights reserved.
//

#import "AppDelegate.h"

#import <PotionStorefront/PotionStorefront.h>

@implementation AppDelegate

- (IBAction)buy:(id)sender
{
	[[PotionStorefront sharedStorefront] setDelegate:self];
	[[PotionStorefront sharedStorefront] setPotionStoreURL:[NSURL URLWithString:@"http://localhost:3000/store"]];
	[[PotionStorefront sharedStorefront] setProductsPlistURL:[NSURL URLWithString:@"http://getconcentrating.com/c8_storefront_products.plist"]];
	[[PotionStorefront sharedStorefront] setWebStoreSupportsPayPal:YES googleCheckout:YES];
	[[PotionStorefront sharedStorefront] beginSheetModalForWindow:mainWindow];
}

@end
