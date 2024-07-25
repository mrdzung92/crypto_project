<?php
namespace app\api\middleware;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use think\facade\Config;

class CheckToken
{
    public function handle($request, \Closure $next)
    {
        $redis = new \think\cache\driver\Redis(Config::get('cache.stores.redis'));

        $token = $request->header('Authorization');
        $key = Config::get('config.jwt_secret_key');
        if (!$token) {
            $token = 'bye bye';
        }
        try {
            $decoded = JWT::decode($token, new Key($key, 'HS256'));
            $existingUser = $redis->hgetall("user:$decoded->username");

            if (!$existingUser || $existingUser['token'] !== $token) {
                throw new \Exception('token error');
            }
            $request->payload = (array) $decoded;
        } catch (\Exception $e) {
            return json(['code' => 0, 'info' => 'Invalid token: ' . $e->getMessage(), 'data' => []], 401);
        }

        return $next($request);
    }

}
