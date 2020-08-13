import "bootstrap";
import 'plugins/flatpickr';
import { payment } from '../payment';
import { stripeProcess } from '../stripePayment';
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
import { addAmenity } from '../createAmenity';
import { newRoomFieldHandler } from '../createRoomAttribute';
import { selectAmenity } from '../selectAmenity';
// import { selectMoveInDate } from '../selectMoveInBookingForm';
import { deleteUnnecessaryDays } from '../bookingFormMoveOutDates';
import { addEventListenersToDateField } from '../bookingForm/dateHandler'

import { addEventListenerToTaC } from '../termsAndConditions'
// import { datepicker } from '../datepicker';

import { addEventListenerToAttendanceButtons } from '../updateWelcomeCallAttendance'
import { addEventListenerToListContextContainer } from '../openUserModal'

// import { addEventListenerToTableTabs } from '../modalTabs'

// addEventListenerToListContextContainer();
addEventListenerToAttendanceButtons();
// addEventListenerToTableTabs();
payment();
// stripeProcess();
onlyOneBox();
socialMediaForms();
expandConfirm();
showUserInfo();
noNavbar();
checkDates();
addCoupleOption();
infoOnHovering();
// checkBookingFormDuration();
previewImages();
fieldHandler();
checkPricesNames();
selectAmenity();
// selectMoveInDate();
addEventListenersToDateField();
// datepicker();
// deleteUnnecessaryDays();
addEventListenerToTaC();

// document.addEventListener('turbolinks:load', () => {
  initMapbox();
  initAutocomplete();
  addAmenity()
  newRoomFieldHandler();
  signing();
// })
