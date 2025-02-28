//  
//  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
//  project.
//  
//  Copyright (C) 1998-2022 OpenLink Software
//  
//  This project is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License as published by the
//  Free Software Foundation; only version 2 of the License, dated June 1991.
//  
//  This program is distributed in the hope that it will be useful, but
//  WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
//  General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License along
//  with this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
//  
//  
using System;

[Serializable]
public class Point_10
{
  public Double x;
  public Double y;

  public Point_10 ()
    {
      x = 0;
      y = 0;
    }
  public Point_10 (Double new_x, Double new_y)
    {
      x = new_x;
      y = new_y;
    }

  public Double distance (Point_10 p)
    {
      Double ret;

      ret =  Math.Sqrt ((p.x - this.x) * (p.x - this.x) + (p.y - this.y) * (p.y - this.y));

      return ret;
    }
}
