import "bootstrap";
import { stripeProcess } from '../stripePayment'
import { onlyOneBox } from '../onlyOneBox';
import { socialMediaForms } from '../applySocialMediaForms';
import { expandConfirm } from '../welcomeCallCalendar';
import { showUserInfo } from '../welcomeCallCalendar';
import { noNavbar } from '../noNavbar';
import { checkDates } from '../bookingDates';
import { addCoupleOption } from '../applyCoupleSection';
import { infoOnHovering } from '../hover_effect_for_info'
import { checkBookingFormDuration } from '../bookingFormCheck'
import { signing } from '../signingProcess'

stripeProcess();
onlyOneBox();
socialMediaForms();
expandConfirm();
showUserInfo();
noNavbar();
checkDates();
addCoupleOption();
infoOnHovering();
checkBookingFormDuration();
signing();
