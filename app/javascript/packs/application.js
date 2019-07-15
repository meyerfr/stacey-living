import "bootstrap";
import { addEventListenerToDuration } from '../updatePricingInBookingForm';
import { addEventListenerToAllSocialMediaInputs } from '../openSocialMediaForm';
import { injectSigningProcess } from './signature'
import { stripeProcess } from '../stripePayment';

addEventListenerToDuration();
addEventListenerToAllSocialMediaInputs();
injectSigningProcess();
stripeProcess();
