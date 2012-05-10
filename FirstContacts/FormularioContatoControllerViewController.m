//
//  FormularioContatoControllerViewController.m
//  FirstContacts
//
//  Created by ios2686 on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormularioContatoControllerViewController.h"
#import "Contato.h"

@interface FormularioContatoControllerViewController ()

@end

@implementation FormularioContatoControllerViewController
@synthesize nome;
@synthesize email;
@synthesize telefone;
@synthesize endereco;
@synthesize site;
@synthesize delegate;

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
    [super viewDidLoad];
    self.title = @"Adicionar";
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(cancelaForm)];
    btnBack.title = @"Voltar";
    self.navigationItem.leftBarButtonItem = btnBack;
    
    UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc]initWithTitle:@"Salvar" style:UIBarButtonItemStylePlain target:self action:@selector(salvaContato)];
    btnAdd.title = @"Adicionar";
    self.navigationItem.rightBarButtonItem = btnAdd;
}

- (void)viewDidUnload
{
    [self setNome:nil];
    [self setEmail:nil];
    [self setTelefone:nil];
    [self setEndereco:nil];
    [self setSite:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) cancelaForm{
    [self dismissModalViewControllerAnimated:YES];
}
-(void) salvaContato{
    Contato *contato = [[Contato alloc]init];
    [contato setNome:nome.text];
    [contato setEmail:email.text];
    [contato setEndereco:endereco.text];
    [contato setTelefone:telefone.text];
    [contato setSite:site.text];
    
    [delegate salvaContato:contato];
    [self dismissModalViewControllerAnimated:YES];
}

@end
