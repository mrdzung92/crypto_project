<?php
namespace app\model;

use think\admin\Model;
use think\facade\Db;

class UsersModel extends Model
{
    protected $table = 'users';

    /**
     * 获取下级用户 id,账号，代理级别，上级id
     * @param int $uid 用户id
     * @param int level 获取级别，不填写全部整条代理都获取
     */
    public function getAgentLevel($uid, $level = '')
    {
        $sql = "WITH RECURSIVE subordinates AS (
                SELECT id,username, parent_id, 1 AS LEVEL FROM  users   WHERE   parent_id = $uid
                 UNION ALL
                SELECT u.id,u.username,u.parent_id, sub.level + 1 FROM  users u INNER JOIN subordinates sub ON u.parent_id = sub.id
                ";
        if ($level !== '') {
            $sql .= "WHERE  sub.level < $level";

        }

        $sql .= ") SELECT id, username, parent_id,level FROM  subordinates;";
        $query = Db::query($sql);
        return $query;
    }

    public function getAgentMemberDetail($uid, $level = '')
    {
        $sql = "WITH RECURSIVE subordinates AS (
                SELECT id,username, parent_id,register_time, 1 AS LEVEL FROM  users   WHERE   parent_id = $uid
                 UNION ALL
                SELECT u.id,u.username,u.parent_id,u.register_time, sub.level + 1 FROM  users u INNER JOIN subordinates sub ON u.parent_id = sub.id
                ";
        if ($level !== '') {
            $sql .= "WHERE  sub.level < $level";

        }

        $sql .= ") SELECT id, username,level,0 AS rebate ,FROM_UNIXTIME(register_time) AS register_time FROM  subordinates WHERE level = $level;";
        $query = Db::query($sql);
        return $query;
    }

}
