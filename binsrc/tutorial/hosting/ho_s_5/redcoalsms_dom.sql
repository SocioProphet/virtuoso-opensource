--  
--  $Id$
--  
--  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
--  project.
--  
--  Copyright (C) 1998-2022 OpenLink Software
--  
--  This project is free software; you can redistribute it and/or modify it
--  under the terms of the GNU General Public License as published by the
--  Free Software Foundation; only version 2 of the License, dated June 1991.
--  
--  This program is distributed in the hope that it will be useful, but
--  WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
--  General Public License for more details.
--  
--  You should have received a copy of the GNU General Public License along
--  with this program; if not, write to the Free Software Foundation, Inc.,
--  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
--  
--  
create procedure import_in_clr ()
{
  exec ('USE CLR1');
  {
    declare exit handler for sqlstate '*', not found { exec ('USE DB');resignal; };
    DB..import_clr (vector ('redcoalsms_dom'), vector ('redcoalsms_dom.redcoalsmssvc'), unrestricted =>1);
  }
  exec ('USE DB');
}
;

import_in_clr ()
;

drop table CLR1..Suppliers
;

create table CLR1..Suppliers
(
  SupplierID INTEGER,
  CompanyName VARCHAR(40),
  ContactName VARCHAR(30),
  ContactTitle VARCHAR(30),
  Address VARCHAR(60),
  City VARCHAR(15),
  Region VARCHAR(15),
  PostalCode VARCHAR(10),
  Country VARCHAR(15),
  Phone VARCHAR(24),
  Fax VARCHAR(24),
  HomePage LONG VARCHAR,
  PRIMARY KEY (SupplierID)
)
;

create procedure CLR1..redcoal_send_sms (in msg varchar)
{
  declare _ClientSerialNo, _SMSKey, _SenderName, _SenderEmail, _recepient, reply varchar;
  _ClientSerialNo := connection_get ('ho_s_3.Redcoal.ClientSerialNo');
  _SMSKey := connection_get ('ho_s_3.Redcoal.SMSKey');
  _SenderName := 'Virtuoso Server';
  _SenderEmail := connection_get ('ho_s_3.Redcoal.SenderEmail');
  _recepient := connection_get ('ho_s_3.MGRPhone');
  if (isstring (_ClientSerialNo) and isstring (_SMSKey) and isstring (_recepient) and
      length (_ClientSerialNo) > 0 and length (_SMSKey) > 0 and length (_recepient) > 0)
    {
      declare svc CLR1..redcoalsms_dom_redcoalsmssvc;
      svc := new CLR1..redcoalsms_dom_redcoalsmssvc (_ClientSerialNo, _SMSKey, _SenderName, _SenderEmail);
      reply :=  svc.sendSms (_recepient, msg);
      if (reply <> 'No Error')
        signal ('42000', sprintf ('Error sending SMS to %.200s : %.200s', _recepient, reply));
    }
}
;


create trigger send_sms_to_mgr_new_supp after insert on CLR1..Suppliers referencing new as N
{
  CLR1..redcoal_send_sms (sprintf ('Added: Supplier %d', N.SupplierID));
}
;

create trigger send_sms_to_mgr_mod_supp after update on CLR1..Suppliers referencing old as O, new as N
{
  CLR1..redcoal_send_sms (sprintf ('Modified: Supplier %d', N.SupplierID));
}
;

create trigger send_sms_to_mgr_mod_supp after delete on CLR1..Suppliers referencing old as O
{
  CLR1..redcoal_send_sms (sprintf ('Deleted: Supplier %d', O.SupplierID));
}
;

