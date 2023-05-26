# 公式の Ruby 3.0 イメージをベースにします
FROM ruby:3.1.3

# コンテナ内の作業ディレクトリを設定します
WORKDIR /app

# システムの依存関係をインストールします
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Rails ジェムをインストールします
RUN gem install rails --version 7.0.3
# Gemfile と Gemfile.lock をコンテナにコピーします
COPY Gemfile Gemfile.lock ./

# プロジェクトの依存関係をインストールします
RUN bundle install

# アプリケーションのコードをコンテナにコピーします
COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# 環境変数を設定します
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true

# アセットをプリコンパイルします
RUN rails assets:precompile

# Rails サーバー用にポート 3000 を公開します
EXPOSE 3000

# Rails サーバーを起動します
CMD ["rails", "server", "-b", "0.0.0.0"]

