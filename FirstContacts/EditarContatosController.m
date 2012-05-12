//
//  EditarContatosController.m
//  FirstContacts
//
//  Created by ios2686 on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditarContatosController.h"
#import "Contato.h"


@interface EditarContatosController ()
    @property(nonatomic,strong) Contato *contato;
    -(void) preencheFormComContato;
@end

@implementation EditarContatosController

@synthesize contato;

-(id)initWithContato:(Contato *)c{
    self = [super initWithNibName:@"FormularioContatoControllerViewController" bundle:[NSBundle mainBundle]];
    if (self){
        self.contato = c;
    }    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UIBarButtonItem *alterar = [[UIBarButtonItem alloc] initWithTitle:@"Alterar" style:UIBarButtonItemStylePlain target:self action:@selector(alterar)];
    self.navigationItem.rightBarButtonItem = alterar;
    [self preencheFormComContato];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) preencheFormComContato{
    [self.nome setText:contato.nome];
    [self.email setText:contato.email];
    [self.telefone setText:contato.telefone];
    [self.endereco setText:contato.endereco];
    [self.site setText:contato.site];    
}

-(void) alterar{
    [contato setNome:self.nome.text];
    [contato setEmail:self.email.text];
    [contato setEndereco:self.endereco.text];
    [contato setSite:self.site.text];
    [contato setTelefone:self.telefone.text];
    
    [self.delegate contatoAlteradoComSucesso];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
