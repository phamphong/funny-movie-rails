class MoviesController < ApplicationController
  skip_before_action :authenticate_request, only: %i[search]

    # POST /share
    def share
      @url = params[:url];
      puts @url;
      VideoInfo.provider_api_keys = { youtube: 'AIzaSyDlb2P_084b91cloXq5T2ycO9ZEVrFGRMo' }
      video = VideoInfo.new(@url)
      @movie = @current_user.movies.create(
        title: video.title,
        code: video.video_id,
        url: params[:url],
        description: video.description,
        user_email: @current_user.email,
      )
      if @movie.save
        response = {
          title: video.title,
          url: params[:url],
          user_email: @current_user.email,
        }
        ActionCable.server.broadcast("messages", response)
        render json: response, status: :created
      else
        render json: @movie.errors, status: 500
      end

    end

    # GET /all
    def all
      render json: {
        data: Movie.all(),
        total: Movie.count
      };
    end

    # POST /search
    def search
      render json: {
        data: Movie.order("id DESC").paginate(page: paging[:pageIndex], per_page: paging[:pageSize]),
        total: Movie.count
      };
    end

    private
    def movie_params
      params.permit(
        :url,
      )
    end

    private
    def paging
      params.permit(
        :pageIndex,
        :pageSize,
      )
    end
end
