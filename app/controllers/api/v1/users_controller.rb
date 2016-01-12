class Api::V1::UsersController < Lina::ApplicationController
  rescue_from ::Exception, with: :error_occurred
    
  def error_occurred(e)
    render json: { error: e.message}
  end

  # def new
  define_action :new, {
    name: '创建玩家',
    description: '玩家名字不能重复，传入玩家名字',
    params: {
      type: 'object',
      required: [ 'name' ],
      properties: {
        name: {
          type: 'string',
          description: '玩家名字',
        }
      }
    },
    return: {
      type: 'object',
      required: [ 'code' ],
      properties: {
        code: {
          type: 'string',
          description: '成功返回1，失败返回0',
        }
      }
    }
  } do
    # write code here, It's the same as before
    query = User.pluck(:name).index(params[:name])
    if query == nil
      User.create(name: params[:name])
      render json: { code: "1" }
    else
      render json: { code: "0" }
    end
  end

  # def player_rank
  define_action :player_rank, {
    name: 'player_rank',
    description: '发送玩家当前最高分，获取排名',
    params: {
      type: 'object',
      required: ['name', 'classic_score'],
      properties: {
        name: {
          type: 'string',
          description: '玩家名字',
        },
        classic_score: {
          type: 'string',
          description: '玩家分数'
        }
      }
    },
    return: {
      type: 'object',
        required: [ 'code', 'rank' ],
        properties: {
          code: {
            type: 'string',
            description: '成功返回1，玩家不存在返回0',
          },
          rank: {
            type: 'integer',
            description: '玩家排名',
          }
        }
    }
  } do
    # write code here, It's the same as before
    @user = User.find_by(name: params[:name])
    if @user == nil
      render json: { code: "0", rank: -1 }
    else
      @user.classic_score = params[:classic_score]
      @user.save
      user_rank = User.order(classic_score: :desc).pluck(:id).index(@user.id) + 1
      render json: { code: "1", rank: user_rank }
    end
    
  end

  # def ranking
  define_action :ranking, {
    name: 'ranking',
    description: '查询前n名的玩家数据',
    params: {
      type: 'object',
      required: [ 'player_count' ],
      properties: {
        count: {
          type: 'string',
          description: '前几名',
        }
      }
    },
    return: {
      type: 'object',
      required: [ 'player_infos' ],
      description: '玩家信息数组',
    }
  } do
    # write code here, It's the same as before
    hash_info = {}
    hash_info[:player_infos] = []

    last_index = params[:player_count].to_i - 1

    if last_index >= 0
      @users_info = User.order(classic_score: :desc).pluck(:name, :classic_score)[0..last_index]
      #collect info data
      actual_count = @users_info.length
      actual_count.times do |i|
        hash_info[:player_infos].append({
            name: @users_info[i][0],
            classic_score: @users_info[i][1]
          })
      end
    end
    
    render json: hash_info
  end
end
