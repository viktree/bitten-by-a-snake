"use strict";

const Alexa = require("alexa-sdk");

const SKILL_NAME = "bitten-by-a-snake";

const HELP_MESSAGE = "Have you ever been bitten by a snake?";
const HELP_REPROMPT = "What can I help you with?";
const STOP_MESSAGE = "Stay safe, and don't get bitten by snakes.";

const responses = [
  "No, I have not been bitten by a mongoose.",
  "No, but humans have beaten snakes.",
  "No I have not been bitten by a snake."
];

const handlers = {
  LaunchRequest: function() {
    this.emit("BittenBySnakeIntent");
  },
  BittenBySnakeIntent: function() {
    const roulettedResponseIndex = Math.floor(Math.random() * responses.length);
    const output = responses[roulettedResponseIndex];

    this.response.cardRenderer(SKILL_NAME, output);
    this.response.speak(output);
    this.emit(":responseReady");
  },
  "AMAZON.HelpIntent": function() {
    const speechOutput = HELP_MESSAGE;
    const reprompt = HELP_REPROMPT;

    this.response.speak(speechOutput).listen(reprompt);
    this.emit(":responseReady");
  },
  "AMAZON.CancelIntent": function() {
    this.response.speak(STOP_MESSAGE);
    this.emit(":responseReady");
  },
  "AMAZON.StopIntent": function() {
    this.response.speak(STOP_MESSAGE);
    this.emit(":responseReady");
  }
};

exports.handler = function(event, context, callback) {
  const alexa = Alexa.handler(event, context, callback);
  alexa.APP_ID = process.env.ALEXA_SKILL_ID;
  alexa.registerHandlers(handlers);
  alexa.execute();
};
