class Api::V1::PingController < ApplicationController
    def show
      render json: {response: "pong"}
    end
  end
