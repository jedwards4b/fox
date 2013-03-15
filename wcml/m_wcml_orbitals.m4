define(`TOHWM4_orbital_subs', `dnl
  subroutine cmlAddMolecularOrbitals_$1(xf, nbasisfunctions, norbitals, aotypes, alphaeigenvalues, &
alphaoccupancies, alphasymmetries, alphavectors, betaeigenvalues, betaoccupancies, betasymmetries, betavectors, &
myid)
    type(xmlf_t), intent(inout) :: xf
    integer, intent(in) :: nbasisfunctions
    integer, intent(in) :: norbitals
    character(len=*), intent(in)           :: myid                      
    character(len=*), intent(in)           :: aotypes(nbasisfunctions)
    real(kind=$1), intent(in)              :: alphaeigenvalues(norbitals)
    real(kind=$1), intent(in)              :: alphaoccupancies(norbitals)
    character(len=*), intent(in)           :: alphasymmetries(norbitals)
    real(kind=$1), intent(in)              :: alphavectors(nbasisfunctions,norbitals)
    real(kind=$1), intent(in), optional    :: betaeigenvalues(norbitals)
    real(kind=$1), intent(in), optional    :: betaoccupancies(norbitals)
    character(len=*), intent(in), optional :: betasymmetries(norbitals)
    real(kind=$1), intent(in), optional    :: betavectors(nbasisfunctions,norbitals)

#ifndef DUMMYLIB
    integer          :: i
    character(len=6) :: mon

    call cmlStartList(xf=xf, dictRef="molecularOrbitals", id=trim(myid))
    call stmAddValue(xf=xf, value=aotypes(1:nbasisfunctions), dictRef="atomicOrbitalDescriptions", &
                     id="aoDescriptions",delimiter="|")
    do i = 1, norbitals
       write(mon,"(i6)") i
       call cmlStartList(xf=xf, dictRef="molecularOrbital", id=trim("molecularOrbital."//adjustl(mon)))
       call stmAddValue(xf=xf, value=alphaeigenvalues(i), dictRef="orbitalEnergy")
       call stmAddValue(xf=xf, value=trim(alphasymmetries(i)), dictRef="orbitalSymmetry")
       if (present(betavectors)) call stmAddValue(xf=xf, value="alpha", dictRef="orbitalSpin")
       call stmAddValue(xf=xf, value=alphaoccupancies(i), dictRef="orbitalOccupancy")
       call stmAddValue(xf=xf, value=alphavectors(1:nbasisfunctions,i), dictRef="aoVector")
       call cmlEndList(xf)
    enddo
    if (present(betavectors)) then
       do i = 1, norbitals
          write(mon,"(i6)") i+norbitals
          call cmlStartList(xf=xf, dictRef="molecularOrbital", id=trim("molecularOrbital."//adjustl(mon)))
          call stmAddValue(xf=xf, value=betaeigenvalues(i), dictRef="orbitalEnergy")
          call stmAddValue(xf=xf, value=trim(betasymmetries(i)), dictRef="orbitalSymmetry")
          call stmAddValue(xf=xf, value="beta", dictRef="orbitalSpin")
          call stmAddValue(xf=xf, value=betaoccupancies(i), dictRef="orbitalOccupancy")
          call stmAddValue(xf=xf, value=betavectors(1:nbasisfunctions,i), dictRef="aoVector")
          call cmlEndList(xf)
       enddo
    endif
    call cmlEndList(xf)
#endif

  end subroutine cmlAddMolecularOrbitals_$1

')dnl
dnl

!
! This file is AUTOGENERATED
! To update, edit m_wcml_orbitals.m4 and regenerate

module m_wcml_orbitals

  use fox_m_fsys_realtypes, only: sp, dp
  use FoX_wxml, only: xmlf_t
#ifndef DUMMYLIB
  use m_wcml_lists, only: cmlStartList, cmlEndList
  use m_wcml_stml, only: stmAddValue

! Fix for pgi, requires this explicitly:
  use m_wxml_overloads
#endif

  implicit none
  private

  interface cmlAddMolecularOrbitals
    module procedure cmlAddMolecularOrbitals_sp
    module procedure cmlAddMolecularOrbitals_dp
  end interface

  public :: cmlAddMolecularOrbitals

contains

TOHWM4_orbital_subs(`sp')

TOHWM4_orbital_subs(`dp')

end module m_wcml_orbitals