pp_addhdr('
#include <SpiceUsr.h>
');
pp_def(
       'axisar',
       Pars => 'double axis(n); double angle(); double [o]r(n,n);',
       Code => 'axisar_c($P(axis), $angle(), $P(r));',
       Doc => '',
      );
pp_def(
       'b1900',
       Pars => 'double [o]a();',
       Code => '$a() = b1900_c();',
       Doc => '',
      );
pp_def(
       'b1950',
       Pars => 'double [o]a();',
       Code => '$a() = b1950_c();',
       Doc => '',
      );
pp_def(
       'badkpv',
       Pars => 'int [o]a(); byte caller(); byte name(); byte comp(); int size(); int divby(); byte type();',
       Code => '$a() = badkpv_c($P(caller),$P(name),$P(comp),$size(),$divby(),$type());',
       Doc => '',
      );
pp_def(
       'bodc2n',
       Pars => 'int code(); byte [o]name(n); int [o]found();',
       Code => 'int nn = $SIZE(n);
	        if (nn > 32) printf ("bodc2n warning: maximum size of name is 32\n");
                bodc2n_c((SpiceInt) $code(),(SpiceInt) nn + 1, $P(name), $P(found));',
       Doc => 'Giving the length of name isn\'t necessary.  PDL::Char puts single quotes around strings handed to it.  The return value you want is inside the single quotes, possibly ending with whitespace',
      );
pp_def(
       'boddef',
       Pars => 'byte name(); int code();',
       Code => 'boddef_c($P(name),$code());',
       Doc => '',
      );
pp_def(
       'bodeul',
       Pars => 'int body(); double et(); double [o]ra(); double [o]dec(); double [o]w(); double [o]lambda();',
       Code => 'bodeul_($P(body), $P(et), $P(ra), $P(dec), $P(w), $P(lambda));',
       Doc => '',
       );
pp_def(
       'bodfnd',
       Pars => 'int [o]a(); int body(); byte item();',
       Code => '$a() = bodfnd_c($body(), $P(item));',
       Doc => '',
      );
pp_def(
       'bodmat',
       Pars => 'int body(); double et(); double [o]tipm(i,i);',
       Code => 'int is = $SIZE(i);
	        if (is != 3) {
	            barf("tipm must be a 3x3 matrix");
	        } else {
                    bodmat_($P(body),$P(et),$P(tipm));
                }',
       Doc => '',
       );
pp_def(
       'bodn2c',
       Pars => 'byte name(n); int [o]c(); int [o]found();',
       Code => 'bodn2c_c($P(name), (SpiceInt *) $P(c), $P(found));',
       Doc => '',
       );
pp_def(
       'bodvar',
       Pars => 'int body(); byte item(n); int [o]dim(); double [o]values();',
       Code => 'bodvar_c($body(), $P(item), (SpiceInt *) $P(dim), $P(values));',
       Doc => '',
       );
pp_def(
       'brcktd',
       Pars => 'double [o]a(); double number(); double end1(); double end2();',
       Code => '$a() = brcktd_c($number(), $end1(), $end2());',
       Doc => '',
      );
pp_def(
       'brckti',
       Pars => 'int [o]a(); int number(); int end1(); int end2();',
       Code => '$a() = brckti_c($number(), $end1(), $end2());',
       Doc => '',
      );
pp_def(
      'ckgp',
      Pars => 'int inst(); double sclkdp(); double tol(); byte ref(); double [o]cmat(n,n); double [o]clkout(); int [o]found();',
      Code => 'int scmat = $SIZE(n);
               if (scmat != 3 ) {
	           barf("ckgp requires cmat to be a 3x3 matrix");
               } else {
                   ckgp_c($inst(), $sclkdp(), $tol(), $P(ref), $P(cmat), $P(clkout), $P(found));
               }',
      Doc => '',
      );
pp_def(
      'ckgpav',
      Pars => 'int inst(); double sclkdp(); double tol(); byte ref(); double [o]cmat(n,n); double [o]av(n); double [o]clkout(); int [o]found();',
      Code => 'int scmat = $SIZE(n);
               if(scmat != 3) {
                   barf("ckgpav requires cmat to be a 3x3 matrix and av to be a 3 dimensional vector");
               } else {
	           ckgpav_c($inst(), $sclkdp(), $tol(), $P(ref), $P(cmat), $P(av), $P(clkout), (SpiceBoolean *)$P(found));
               }',
      Doc => '',
      );
pp_def(
       'cklpf',
       Pars => 'byte filename(n); int [o]handle();',
       Code => 'cklpf_c($P(filename), (SpiceInt *)$P(handle));',
       Doc => '',
      );
pp_def(
       'ckopn',
       Pars => 'byte fname(); byte ifname(); int ncomch(); int [o]handle();',
       Code => 'ckopn_c($P(fname), $P(ifname), $ncomch(), (SpiceInt *)$P(handle));',
       Doc => '',
      );
pp_def(
       'cidfrm',
       Pars => 'int cent(); int lenout(); int [o]frcode(); byte [o]frname(); int [o]found();',
       Code => 'cidfrm_c($cent(), $lenout(), (SpiceInt *) $P(frcode), $P(frname), $P(found));',
       Doc => '',
      );
pp_def(
       'deltet',
       Pars => 'double epoch(); byte eptype(n); double [o]delta();',
       Code => 'int ns = $SIZE(n);
                deltet_($P(epoch),$P(eptype),$P(delta),ns);',
       Doc => '',
       );
pp_def(
       'dpr',
	Pars => 'double [o]a();',
	Code => '$a() = dpr_c();',
	Doc => '',
       );
pp_def(
       'erract',
	Pars => 'byte op(i); byte [o]action(j);',
	Code => 'int is = $SIZE(i); int js = $SIZE(j);
	         erract_c($P(op),is,$P(action));',
	Doc => "Giving the size of op is unnecessary",
       );
pp_def(
       'errprt',
	Pars => 'byte op(i); byte [o]list(j);',
	Code => 'int is = $SIZE(i); int js = $SIZE(j);
	         errprt_c($P(op),is,$P(list));',
	Doc => "Giving the size of op is unnecessary",
       );
pp_def(
       'et2lst',
       Pars => 'double et(); int body(); double lng(); byte type(i); int [o]hr(); int [o]mn(); int [o]sc(); byte [o]time(j); byte [o]ampm(k);',
       Code => 'int is = $SIZE(i); int js = $SIZE(j); int ks = $SIZE(k);
                et2lst_($P(et), $P(body), $P(lng), $P(type), $P(hr),
                        $P(mn), $P(sc), $P(time), $P(ampm), is, js, ks);',
       Doc => '',
       );
pp_def(
       'et2utc',
       Pars => 'double et(); byte format(i); int prec(); byte [o]utcstr(j);',
       Code => 'int sutcstr = $SIZE(j);
                et2utc_c($et(), $P(format), $prec(), sutcstr, $P(utcstr));',
       Doc => 'Passing the length of utcstr is unnecessary.  Make sure you provide a PDL::Char that is big enough.',
      );
pp_def(
       'furnsh',
       Pars => 'byte s(n);',
       Code => 'furnsh_c($P(s));',
       Doc => '',
       );
pp_def(
       'georec',
       Pars => 'double lon(); double lat(); double alt(); double re(); double f(); double [o]rectan(n);',
       Code => 'georec_c($lon(),$lat(),$alt(),$re(),$f(),$P(rectan));',
       Doc => '',
       );
pp_def(
       'getfov',
       Pars => 'int instid(); int room(); int shapelen(); int framelen();
                byte [o]shape(); byte [o]frame(); double [o]bsight(n);
                int [o]n(); double [o]bounds(m,n);',
       Code => 'getfov_c($instid(), $room(), $shapelen(), $framelen(),
                         $P(shape), $P(frame), $P(bsight), (SpiceInt *) $P(n),
                         $P(bounds));',
       Doc => '',
      );
pp_def(
       'invstm',
       Pars => 'double mat(n,n); double [o]invmat(n,n);',
       Code => 'invstm_($P(mat), $P(invmat));',
       Doc => '',
       );
pp_def(
       'mxmg',
       Pars => 'double m1(m,n); double m2(n,o); double [o]mout(m,o);',
       Code => 'int ms = $SIZE(m); int ns = $SIZE(n); int os = $SIZE(o);
                mxmg_c($P(m1), $P(m2), ms, ns, os, $P(mout));',
       Doc =>  'Note that sizes aren\'t required here, since piddles know their  own sizes',
       );
pp_def(
       'mxv',
       Pars => 'double m1(n,n); double v2(n); double [o]vout(n);',
       Code => 'int ns = $SIZE(n);
                if(ns != 3) {
		    barf ("mxv is for 3x3 matrices.  Use mxvg for general matrices\n");
		  } else {
		      mxv_c($P(m1), $P(v2), $P(vout));
                  }',
       Doc => 'This checks to make sure if the matrix and vectors are three dimensional, and croaks otherwise.',
       );
pp_def(
       'mxvg',
       Pars => 'double m1(m,n); double v2(m); double [o]vout(n);',
       Code => 'int ns = $SIZE(n); int ms = $SIZE(m);
                mxvg_c($P(m1), $P(v2), ms, ns, $P(vout));',
       Doc => '',
       );
pp_def(
       'nearpt',
       Pars => 'double positn(n); double a(); double b(); double c(); 
                double [o]npoint(n); double [o]alt();',
       Code => 'nearpt_c($P(positn), $a(), $b(), $c(), $P(npoint), $P(alt));',
       Doc => '',
      );
pp_def(
       'npedln',
       Pars => 'double a(); double b(); double c(); double linept(n);
                double linedr(n); double [o]pnear(n); double dist();',
       Code => 'npedln_c($a(), $b(), $c(), $P(linept), $P(linedr),
                         $P(pnear), $P(dist));',
       Doc => '',
       );
pp_def(
       'pxform',
       Pars => 'byte from(); byte to(); double et(); double [o]rotate(n,n);',
       Code => 'pxform_c($P(from), $P(to), $et(), $P(rotate));',
       Doc => '',
       );
pp_def('reclat',
       Pars => 'double rectan(i); double [o]radius(); double [o]longitude(); double [o]latitude();',
       Code => 'reclat_c($P(rectan), $P(radius), $P(longitude), $P(latitude));',
       Doc => '',
       );
pp_def(
       'recrad',
       Pars => 'double rectan(n); double [o]range(); double [o]ra(); double [o]dec();',
       Code => 'recrad_c($P(rectan), $P(range), $P(ra), $P(dec));',
       Doc => '',
      );
pp_def(
       'rpd',
	Pars => 'double a();',
	Code => '$a() = rpd_c();',
	Doc => '',
       );
pp_def(
       'sce2s',
        Pars => 'int sc(); double et(); byte [o]sclkch(n);',
	Code => 'int ssclkch = $SIZE(n);
                 sce2s_c($sc(), $et(), ssclkch, $P(sclkch));',
        Doc => 'Passing the length of sclkch isn\'t necessary',
      );
pp_def(
       'spkez',
       Pars => 'int targ(); double et(); byte ref(i); byte abcorr(j); int obs(); double [o]starg(n); double [o]lt();',
       Code => 'spkez_c($targ(), $et(), $P(ref), $P(abcorr), $obs(), $P(starg), $P(lt));',
       Doc => '',
       );
pp_def(
       'surfnm',
       Pars => 'double a(); double b(); double c(); double point(n); double [o]normal(n);',
       Code => 'surfnm_c($a(), $b(), $c(), $P(point), $P(normal));',
       Doc => '',
       );
pp_def(
       'sxform',
       Pars => 'byte from(i); byte to(j); double et(); double [o]xform(n,n);',
       Code => 'sxform_c($P(from), $P(to), $et(), $P(xform));',
       Doc => '',
       );
pp_def(
       'tisbod',
       Pars => 'byte ref(); int body(); double et(); double [o]tsipm(n,n);',
       Code => 'tisbod_c($P(ref), $body(), $et(), $P(tsipm));',
       Doc => '',
       );
pp_def(
       'twovec',
       Pars => 'double axdef(i); int indexa(); double plndef(i); int indexp(); double [o]mout(i,i);',
       Code => 'int is = $SIZE(i);
                if (is != 3) {
                    barf("mout must be a 3x3 matrix");
                } else {
                    twovec_c($P(axdef), $indexa(), $P(plndef), $indexp(), $P(mout));
                }',
       Doc => '',
       );
pp_def(
       'unorm',
       Pars => 'double v1(i); double [o]vout(i); double vmag();',
       Code => 'int is = $SIZE(i);
                if (is != 3) {
	            barf("unorm: v1 and vout must be 3 dimensional vectors");
                } else {
                    unorm_c($P(v1),$P(vout),$P(vmag));
                }',
       Doc => '',
       );
pp_def(
       'vequ',
       Pars => 'double v1(n); double [o]v2(n);',
       Code => 'int ns = $SIZE(n);
                if (ns != 3) {
		    barf("vequ is for length 3 vectors");
		} else {
		    vequ_c($P(v1), $P(v2));
		}',
       Doc => 'Checks to see that the vectors are three dimensional, and croaks otherwise',
      );
pp_def(
       'vminus',
       Pars => 'double v1(n); double [o]v2(n);',
       Code => 'vminus_c($P(v1), $P(v2));',
       Doc => '',
      );
pp_def(
       'utc2et',
       Pars => 'byte utcstr(n); double [o]et();',
       Code => 'utc2et_c($P(utcstr),$P(et));',
       Doc => '',
       );
pp_addpm(<<'EOD');
=head1 NAME

PDL::NAIF -- a PDL interface to JPL's NAIF toolkit

=head1 DESCRIPTION

This package implements an interface to JPL's NAIF toolkit.  The NAIF
toolkit is a collection of routines extensively used to plan for and
analyze data from NASA missions.  (More information about the NAIF
toolkit is available at L<http://pds.jpl.nasa.gov/naif.html> and the
software itself at L<ftp://naif.jpl.nasa.gov/pub/naif/toolkit>.)
Information is provided to the NAIF routines via a series of "kernels"
of various types. (Various kernels are also available at the ftp
site.)  These contain information such as the positions and velocities
of various bodies, including spacecraft, planets and their satellites,
the orientation of spacecraft at various times during their missions,
etc.  Toolkit routines are used to query the kernels for various
quantities of interest.

The NAIF toolkit now comes in both ANSI C and FORTRAN 77, so it's
feasible to construct a Perl interface using the C version.  I had
originally intended to create a L<NAIF> module similar to the
L<PGPLOT> module, usable using standard Perl lists and scalars.
However, too many NAIF routines use multidimensional arrays, and I
don't know enough about XS to write the interface routines to create a
multidimensional Perl array from a C array and vice versa.  When
installing PDL on my new Powerbook G4, I realized that PDL knows how
to handle "real" arrays (i.e. arrays as continuous blocks of data of
the same C type), because that's what it was designed for.  I started
looking through the docs, discovered L<PDL::PP>, and quickly had a
working interface.

This is very preliminary.  I haven't yet implemented all the NAIF
toolkit routines.  So far I've combed through my own programs and have
implemented every NAIF routine I've used in my own code, including
some things that don't really need to be done considering that PDL is
also available (mxv, for example, can just as easily be done in PDL).
There are some quirks.  Many NAIF routines use character strings as
switches, so L<PDL::Char> must be used to construct these strings.
L<PDL::Char> seems to store strings with single quotes on each side of
the content.  This doesn't seem to cause problems on input, but output
routines expecting particular strings will have to both deal with the
single quotes and the whitespace that the F<f2c> string routines put
inside the single quotes.  (NAIF uses F<f2c> extensively.)  Some
routines expect fixed size arrays to be fed to them, so naturally
these have to be predeclared in PDL:

	$et = <some time>;
	$frame = PDL::Char->new("CASSINI_XBAND");
	$reference_frame = PDL::Char->new("J2000");
	$xform = zeroes(6,6);
	PDL::NAIF::sxform($frame,$reference_frame,$et,$xform);

Individual functions aren't documented here.  For details on usage of
specific subroutines, consult the documentation that comes with the
NAIF toolkit.  Differences between the routines here (mostly passing
sizes, since PDL objects know their own sizes and so we can obtain
them directly from the object rather than passing them) are documented
in the short notes above for each routine.

=head1 AUTHOR

	Paul J. Schinder
	NASA Goddard Space Flight Center, Code 693
	schinder@leprss.gsfc.nasa.gov

This code is licensed under the same terms as Perl itself.

=cut

EOD
pp_done;
