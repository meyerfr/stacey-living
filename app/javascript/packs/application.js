import "bootstrap";
import { addEventListenerToDuration } from '../updatePricingInBookingForm';
import { addEventListenerToAllSocialMediaInputs } from '../openSocialMediaForm';
import { injectSigningProcess } from './signature'

addEventListenerToDuration();
addEventListenerToAllSocialMediaInputs();
injectSigningProcess();
