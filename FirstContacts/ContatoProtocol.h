//
//  ContatoProtocol.h
//  FirstContacts
//
//  Created by ios2686 on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@protocol ContatoProtocol <NSObject>

@required
-(void) salvaContato:(Contato *) c;
@end
