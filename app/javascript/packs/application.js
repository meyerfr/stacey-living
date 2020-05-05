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
import { previewImages } from '../imagePreview'
import { fieldHandler } from '../fieldHandler'
import { checkPricesNames } from '../roomFieldPriceElementsNames'
import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';

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
previewImages();
fieldHandler();
checkPricesNames();


document.addEventListener('turbolinks:load', () => {
  initMapbox();
  initAutocomplete();
})
