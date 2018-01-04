call p_organization.proc_insert_institution('Villamos és informatikai',
                                'VI');
                                
call p_organization.proc_update_institution(3,
                                'Építész intézet1111111111',
                                'ÉIII');
                        
call p_organization.proc_insert_department('Mûszaki informatikai tanszék',
                               'MIT',
                               1);
                        
call p_organization.proc_update_department(2,
                                'Rendszer- és szoftvertechnológia tanszék',
                                'RSZT',
                               1);
                               
call p_education.proc_insert_degrees('Mérnökinformatikus',
                           'BSC',
                            2);

call p_education.proc_insert_specialization('Rendszermérnök',
                            2,
                            2);

call p_education.proc_insert_subject('Assembly',
                            1,
                            1,
                            1);
                    
----------------------------
call p_people.


call p_people.proc_insert_student('Fehér',
                            'Rischárd',
                            '1993.10.10',
                            'Pécs',
                            'Pécs',
                            'Boszorkány utca 2',
                            'email@email.hu',
                            '0612345678',
                            '2012.09.03',
                            '2016.02.02',
                            0,
                            1,
                            null,
                            0);

call p_people.proc_update_student('Nagy',
                            'Dávid Ferenc József',
                            '1993.10.10',
                            'Pécs',
                            'Pécs',
                            'Boszorkány utca 2',
                            'email@email.hu',
                            '0612345678',
                            '2012.09.03',
                            '2016.02.02',
                            0,
                            1,
                            null,
                            0,
                            'U2CGGR');

call p_people.proc_delete_student('RD7TEZ');

call p_people.proc_activate_student('RD7TEZ');

call p_people.proc_passivate_student('U2CGGR');

call p_people.proc_insert_teacher('Tóth',
                            'Márta',
                            '1973.10.10',
                            'Pécs',
                            'Pécs',
                            'Boszorkány utca 2',
                            'email@email.hu',
                            '0612345678',
                            '2012.09.03',
                            1);

call p_people.proc_update_teacher('Tóth',
                            'Márta Éva',
                            '1973.10.10',
                            'Pécs',
                            'Pécs',
                            'Boszorkány utca 2',
                            'email@email.hu',
                            '0612345678',
                            '2012.09.03',
                            1,
                            'AV5E5R');
                            
call p_education.proc_insert_teacher_subject('NMSE70',
                            'USXR58',
                            '2018/2019',
                            1);

call p_education.proc_insert_student_subject('QE80BU',
                            'AV5E5R',
                            'S7H0Y2',
                            '2018/2019',
                            1,
                            5);
                            
select * from student_grade_view;

select * from teacher_student_view;
   
select * from subject_organization_view;