//
//  PotionStorefront.h
//  PotionStorefront
//
//  Created by Andy Kim on 7/26/08.
//  Copyright 2008 Potion Factory LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PFOrder.h"
#import "PFAddress.h"
#import "PFProduct.h"

#define DEBUG_POTION_STORE_FRONT 0

@interface PotionStorefront : NSObject
{
}

+ (PotionStorefront *)sharedStorefront;

- (id)delegate;
- (void)setDelegate:(id)delegate;

- (NSURL *)potionStoreURL;
- (void)setPotionStoreURL:(NSURL *)URL;

- (NSURL *)productsPlistURL;
- (void)setProductsPlistURL:(NSURL *)URL;

- (void)setWebStoreSupportsPayPal:(BOOL)flag1 googleCheckout:(BOOL)flag2;

- (void)beginSheetModalForWindow:(NSWindow *)window;

- (void)setHeaderBackgroundColor:(NSColor *)bgColor andTextColor:(NSColor *)textColor;

- (void)validateLicenseName:(NSString *)name andKey:(NSString *)key;
- (void)validateLicenseName:(NSString *)name andKey:(NSString *)key withExtras:(NSDictionary *)theExtras;


// private 
- (void) validateLicense:(NSDictionary *)aDict;

@end



@interface NSObject (PotionStorefrontDelegate)
// Required
- (void)orderDidFinishCharging:(PFOrder *)order;

// Optional -- If you implement this you get the "Unlock with License Key..." button
- (void)showRegistrationWindow:(id)sender;

// Optional -- Used if you call validateLicenseName:andKey:
- (void)licenseValidated:(BOOL)response;

@end
