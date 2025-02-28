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
use BPEL;


BPEL..upload_script ('file:/order/','order.bpel','order.wsdl');
ECHO BOTH $IF $EQU $STATE OK  "PASSED:" "***FAILED:";
ECHO BOTH " Order script upload status:" $STATE "\n";


BPEL..wsdl_process_remote ('OrderService',
	sprintf ('http://localhost:%s/order/servicewsdl.vsp', server_http_port ()), 'file:/order/order.bpel');
ECHO BOTH $IF $EQU $STATE OK  "PASSED:" "***FAILED:";
ECHO BOTH " Order script registered service:" $STATE "\n";

--create procedure BPEL.BPEL.onResult (in orderItemsResponse any) __soap_type '__VOID__'
--{
--   dbg_obj_print ('onResult', orderItemsResponse);
--}
--;


--grant execute on BPEL.BPEL.onResult to BPEL;

