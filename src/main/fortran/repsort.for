c repsort - does a simple sort of replacement reservoir info
c_________________________________________________________________NoticeStart_
c StateMod Water Allocation Model
c StateMod is a part of Colorado's Decision Support Systems (CDSS)
c Copyright (C) 1994-2018 Colorado Department of Natural Resources
c 
c StateMod is free software:  you can redistribute it and/or modify
c     it under the terms of the GNU General Public License as published by
c     the Free Software Foundation, either version 3 of the License, or
c     (at your option) any later version.
c 
c StateMod is distributed in the hope that it will be useful,
c     but WITHOUT ANY WARRANTY; without even the implied warranty of
c     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
c     GNU General Public License for more details.
c 
c     You should have received a copy of the GNU General Public License
c     along with StateMod.  If not, see <https://www.gnu.org/licenses/>.
c_________________________________________________________________NoticeEnd___

          subroutine repsort(n, maxrep, ireprnk, reprnk, reprnkx)
c
c _________________________________________________________
c	Program Description
c
c       Repsort; It does a simple sort of replacement reservoir info
c		Called by GetRep.f that is called by Oprinp.f 
c
c
c _________________________________________________________
c	Dimensions
c
          dimension reprnk(maxrep), ireprnk(maxrep), temp(maxrep)
          real*8 reprnk, reprnkx, temp, c
c
c _________________________________________________________
c
c               Step 1; Initilize

          iout=0
          nlog=99
c
c _________________________________________________________
c
c               Step 2; Check local dimensions

          if(n.gt.maxrep) then
            write(nlog,*) '  Repsort; Local Dimension Exceeded'
            write(nlog,*) '  Repsort; maxrep = ', maxrep
            write(nlog,*) '  Revise common.inc, statem.f & repsort.f'
            goto 9999
          endif
c
c _________________________________________________________
c
c               Step 3; Sort

          do i=1,n
            temp(i) = reprnk(i)
          end do
                         
          imx = 1          
          c  = temp(imx)

          do 120 i1=1,n
            do 110 i2=1,n
              if(temp(i2).lt.c) then
                imx = i2
                c = temp(i2)
              endif
 110         continue
c
            ireprnk(i1) = imx
            temp(imx) = 9999999.
            c = 9999999.
 120      continue                                       
c
c _________________________________________________________
c
c               Step 4; Store minimum Admin # of replacement
c                       reservoirs
          reprnkx = reprnk(ireprnk(1))
c
c _________________________________________________________
c
c               Step 5; Print results

          if(iout.ge.1) then
            write(nlog,129)

            do i=1,n
              n1=ireprnk(i)
              write(nlog,133) i, reprnk(n1), ireprnk(i), reprnkx
            end do
          endif
c
c _________________________________________________________
c
c               Step 6; Return
          return
c
c _________________________________________________________
c
c               Step 7; Error Processing

 9999     write(6,*)  '  Stopped in Repsort, see the log file (*.log)'
          write(99,*) '  Stopped in Repsort'
          write(6,*) 'Stop 1' 
          call flush(6)
          call exit(1)

c
c _________________________________________________________
c
c               Formats
 129      format(/,'  Repsort; sort results',/
     1      10x, ' Rank         Admin # Rep#     Min Admin #',/
     1      10x, ' ____ _______________ ____ _______________')
 133      format('  Repsort;',i5, f16.5, i5, f16.5)

          stop 
          end

