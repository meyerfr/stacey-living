import "bootstrap";
import { addEventListenerToDuration } from '../updatePricingInBookingForm';
import { addEventListenerToAllSocialMediaInputs } from '../openSocialMediaForm';
import { injectSigningProcess } from './signature'
import { stripeProcess } from '../stripePayment';
import { checkBeforeSubmit } from '../pricingCheckBoxes';

addEventListenerToDuration();
addEventListenerToAllSocialMediaInputs();
injectSigningProcess();
stripeProcess();
checkBeforeSubmit();
console.log('applicant.js wird geladen');
