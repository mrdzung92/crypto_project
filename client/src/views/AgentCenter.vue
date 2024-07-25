<template>
    <div class="agent-center">
        <van-nav-bar class="header" :title="headerTitle" left-text="返回" left-arrow @click-left="$router.go(-1)">
            <template #right>
                <img @click.stop="goPath('guize')" src="@/assets/img/common/guize.svg" alt=""
                    style="width: 2.4rem; height: 2.4rem;">
            </template>
        </van-nav-bar>
        <van-popup class="illustrate" v-model:show="showIllustrate" closeable close-icon="close" position="bottom"
            :style="{ height: '50%' }">
            <p class="title">说明</p>
            <van-empty description="暂无数据" />
        </van-popup>
        <div class="agent-content">
            <div class="agent-info">
                <div class="title">
                    <p class="tit">邀请好友一起赚币</p>
                    <p>邀请好友，充值即刻获取佣金</p>
                </div>
                <div class="qr-code">
                    <lay-qrcode :text="link" :width="100" id="qr-invite-code"></lay-qrcode>
                    <div @click="saveImg" class="save-img">下载二维码</div>
                </div>
                <div class="copy">
                    <p class="invite-code">

                        <span>邀请码: {{ agentInfo.invite_code }}</span>
                        <img @click="copy()" class="copy-icon" src="@/assets/img/common/copy.svg" alt="">
                    </p>
                    <p class="invite-code">

                        <span> 推广链接: {{ link }}</span>
                        <img @click="copy('link')" class="copy-icon" src="@/assets/img/common/copy.svg" alt="">
                    </p>
                </div>
            </div>
            <ul class="agent-detail">
                <li class="agent-detail-item">
                    <span class="text">一代人数</span>
                    <span class="count">{{ agentInfo.oneCount }}</span>
                </li>
                <li class="agent-detail-item">
                    <span class="text">二代人数</span>
                    <span class="count">{{ agentInfo.twoCount }}</span>
                </li>
                <li class="agent-detail-item">
                    <span class="text">三代人数</span>
                    <span class="count">{{ agentInfo.threeCount }}</span>
                </li>
                <li class="agent-detail-item">
                    <span class="text">推广总人数</span>
                    <span class="count">{{ agentInfo.sumCount }}</span>
                </li>
                <li class="agent-detail-item">
                    <span class="text">佣金金额</span>
                    <span class="count">{{ agentInfo.sumAmount }}</span>
                </li>
            </ul>
            <div class="agent-list">
                <p class="agent-title">
                    我的推广
                </p>
                <ul class="select-level">
                    <li @click="changeSelectLevel(index)" :class="{ active: activeLevel == index }"
                        v-for="item, index in ['一代', '二代', '三代']" :key="index">{{ item }}</li>
                </ul>
                <div class="list-content">
                    <table>
                        <thead>
                            <tr>
                                <th>用户</th>
                                <th>返佣金额</th>
                                <th>注册时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-if="agentUserList.length == 0">
                                <td colspan="3">
                                    <van-empty description="没有数据" />
                                </td>
                            </tr>
                            <tr v-else-if="loading">
                                <td class="loading-td" colspan="3">
                                    <van-loading type="spinner" />
                                </td>
                            </tr>
                            <tr v-else v-for="item in agentUserList" :key="item.id">
                                <td>{{ item.username }}</td>
                                <td>{{ item.rebate }}</td>
                                <td>{{ item.register_time }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { LayQrcode } from '@layui/layui-vue'
import '@layui/layui-vue/es/qrcode/index.css';
import { showToast } from 'vant';
export default {
    components: {
        LayQrcode
    },
    data() {
        return {
            showIllustrate: false,
            headerTitle: '推广中心',
            agentInfo: {
                sumCount: 0,
                oneCount: 0,
                twoCount: 0,
                threeCount: 0,
                sumAmount: 0,
                invite_code: 'xxxx'
            },
            loading: false,
            level: 1,
            activeLevel: 0,
            agentUserList: [],
            link: ''

        }
    },
    created() {
        this.link = `${window.location.protocol}//${window.location.hostname}${window.location.port ? ':' + window.location.port : ''}/auth/register`
        this.getAgentInfo()
        this.getAgentMemberList()
    },
    methods: {
       async copy(task = ''){
            let target = this.agentInfo.invite_code;
            if(task == 'link') {
                target = this.link
            }
            try {
                await navigator.clipboard.writeText(target);
                showToast('复制成功');
            } catch (err) {
                showToast('复制失败');
            }

        },
        saveImg() {
            const canvas = document.querySelector('#qr-invite-code canvas');
            const width = 300;
            const height = 300;
            const tempCanvas = document.createElement('canvas');
            tempCanvas.width = width;
            tempCanvas.height = height;
            const tempCtx = tempCanvas.getContext('2d');
            tempCtx.drawImage(canvas, 0, 0, canvas.width, canvas.height, 0, 0, width, height);
            const image = tempCanvas.toDataURL('image/png');
            const link = document.createElement('a');
            link.href = image;
            link.download = 'invite_code.png';
            link.click();
        },
        getAgentInfo() {
            this.$wedApi.get('Agent/getAgentDetail').then(res => {
                if (res.data.code === 1) {
                    this.agentInfo = res.data.data
                    this.link += '/' + this.agentInfo.invite_code
                }
            })
        },
        changeSelectLevel(index) {
            this.activeLevel = index,
                this.level = index + 1
            this.getAgentMemberList()
        },
        getAgentMemberList() {
            this.loading = true
            this.$wedApi.get('Agent/getAgentMemberList', { level: this.level }).then(res => {
                this.loading = false
                if (res.data.code === 1) {
                    this.agentUserList = res.data.data
                }
            })
        },
        goPath(path) {
            switch (path) {
                case 'guize':
                    this.showIllustrate = true
                    break;
                default:
                    this.$router.push(path)
                    break
            }

        }
    }
}
</script>

<style lang="scss" scoped>
.agent-center {
    padding-top: 4.6rem;
    min-height: 100vh;

    .agent-content {
        .agent-info {
            background: url('@/assets/img/agent/plugbg.png') no-repeat center;
            background-size: cover;
            padding: 2rem 1.5rem;

            .title {
                .tit {
                    font-size: 2rem;
                    font-weight: bold;

                }
            }

            .qr-code {
                display: flex;
                flex-direction: column;
                justify-content: center;
                position: relative;
                align-items: center;

                .save-img {
                    position: absolute;
                    bottom: -.6rem;
                    color: var(--color-icon);
                }
            }

            .copy {
                margin-top: 1rem;
                font-size: 1.2rem;

                .invite-code {
                    display: flex;
                    align-items: flex-start;
                    justify-content: flex-start;

                    .copy-icon {
                        width: 1.6rem;
                        height: 1.6rem;
                        margin-left: 1.5rem;
                    }

                    &:nth-child(2) {
                        span {
                            width: 70%;
                        }
                    }
                }
            }
        }

        .agent-detail {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
            padding: 1.5rem 0;
            text-align: center;

            .agent-detail-item {

                span {
                    display: block;
                }

                .text {
                    margin-bottom: 1.5rem;
                    color: var(--color-text3);
                }

                .count {
                    font-size: 1.6rem;
                }
            }
        }

        .agent-list {

            // padding: 0 1.5rem 1rem;
            .agent-title {
                font-weight: bold;
                padding-left: 1.5rem;
                padding-bottom: 1.5rem;
            }

            .select-level {
                display: flex;
                justify-content: space-between;
                padding: 1.5rem;
                background: var(--color-bg);

                li {
                    &.active {
                        color: var(--color-icon);
                        font-weight: bold;
                    }
                }
            }

            .list-content {
                // padding: 0 1.5rem;

                table {
                    width: 100%;
                    border-collapse: collapse;


                    thead {
                        tr {
                            font-size: 1.2rem;

                            th {
                                font-weight: bold;
                                color: var(--color-text3);
                            }


                        }
                    }


                    th,
                    td {
                        border: 1px solid var(--color-border2);

                        &:nth-child(1) {
                            text-align: left;
                            padding-left: 1.5rem;
                        }

                        &:nth-child(2) {
                            text-align: center;
                        }

                        &:nth-child(3) {
                            width: 40%;
                            text-align: right;
                            padding-right: 1.5rem;
                        }

                        &.loading-td {
                            height: 10rem;
                            text-align: center;
                            padding-right: 1.5rem;
                            padding-bottom: 2rem;
                        }
                    }

                }

                // .list-head {
                //     display: flex;
                //     justify-content: space-between;

                // }
            }
        }
    }
}
</style>