{
    matrix_id: '636',
    name: 'lp_kb2',
    group: 'LPnetlib',
    description: 'Netlib LP problem kb2: minimize c\'*x, where Ax=b, lo<=x<=hi',
    author: 'J. Tomlin',
    editor: 'D. Gay',
    date: '1989',
    kind: 'linear programming problem',
    problem_2D_or_3D: '0',
    num_rows: '43',
    num_cols: '68',
    nonzeros: '313',
    num_explicit_zeros: '0',
    num_strongly_connected_components: '1',
    num_dmperm_blocks: '1',
    structural_full_rank: 'true',
    structural_rank: '43',
    pattern_symmetry: '0.000',
    numeric_symmetry: '0.000',
    rb_type: 'real',
    structure: 'rectangular',
    cholesky_candidate: 'no',
    positive_definite: 'no',
    notes: 'A Netlib LP problem, in lp/data.  For more information                    
send email to netlib@ornl.gov with the message:                           
                                                                          
	 send index from lp                                                      
	 send readme from lp/data                                                
                                                                          
The following are relevant excerpts from lp/data/readme (by David M. Gay):
                                                                          
The column and nonzero counts in the PROBLEM SUMMARY TABLE below exclude  
slack and surplus columns and the right-hand side vector, but include     
the cost row.  We have omitted other free rows and all but the first      
right-hand side vector, as noted below.  The byte count is for the        
MPS compressed file; it includes a newline character at the end of each   
line.  These files start with a blank initial line intended to prevent    
mail programs from discarding any of the data.  The BR column indicates   
whether a problem has bounds or ranges:  B stands for "has bounds", R     
for "has ranges".  The BOUND-TYPE TABLE below shows the bound types       
present in those problems that have bounds.                               
                                                                          
The optimal value is from MINOS version 5.3 (of Sept. 1988)               
running on a VAX with default options.                                    
                                                                          
                       PROBLEM SUMMARY TABLE                              
                                                                          
Name       Rows   Cols   Nonzeros    Bytes  BR      Optimal Value         
KB2          44     41      291       2526  B    -1.7499001299E+03        
                                                                          
        BOUND-TYPE TABLE                                                  
KB2        UP                                                             
                                                                          
Empty RHS section.                                                        
                                                                          
From John Tomlin.                                                         
On the problems supplied by John Tomlin, MINOS 5.3 reports that about     
10% to 57% of its steps are degenerate:                                   
     Name     Steps  Degen  Percent                                       
     KB2         82     29   35.37                                        
                                                                          
Added to Netlib on  27 June 1989                                          
',
    b_field: 'full 43-by-1
',
    aux_fields: 'c: full 68-by-1
lo: full 68-by-1
hi: full 68-by-1
z0: full 1-by-1
',    norm: '6.242916e+02',
    min_singular_value: '1.233973e-02',
    condition_number: '5.059201e+04',
    svd_rank: '43',
    sprank_minus_rank: '0',
    null_space_dimension: '0',
    full_numerical_rank: 'yes',
    image_files: 'lp_kb2.png,lp_kb2_svd.png,lp_kb2_graph.gif,',
}
