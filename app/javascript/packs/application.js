console.log('application.js wird geladen');
import "bootstrap";
import { checkDuration } from '../checkDurationOfStay';
import { addEventListenerToDuration } from '../updatePricingInBookingForm';
import { addEventListenerToAllSocialMediaInputs } from '../openSocialMediaForm';
import { injectSigningProcess } from './signature'
import { stripeProcess } from '../stripePayment';
import { checkBeforeSubmit } from '../pricingCheckBoxes';

checkDuration();
addEventListenerToDuration();
addEventListenerToAllSocialMediaInputs();
injectSigningProcess();
stripeProcess();
checkBeforeSubmit();
