<template>
    <div class="recharge-apply">
        <van-nav-bar class="header" :title="headerTitle" left-text="返回" left-arrow @click-left="$router.go(-1)">
            <template #right>
                <img @click.stop="goPath('kefu')" src="@/assets/img/common/kefu.svg" alt=""
                    style="width: 2.4rem; height: 2.4rem;">
                <img @click.stop="goPath('/RechargeRecord')" src="@/assets/img/common/jilu.svg" alt=""
                    style="width: 2.4rem; height: 2.4rem; margin-left: 1rem;">
            </template>
        </van-nav-bar>
        <div class="recharge-apply-content">
            <div class="qr-code">
                <img :src="accountRecharge.qr_code" alt="">
            </div>
            <div class="recharge-apply-detail">
                <div class="name">
                    充值地址(USDT-TRC20)
                </div>
                <div class="address">
                    <p>{{ accountRecharge.address }}</p>
                    <img @click="copy" src="@/assets/img/common/copy.svg" alt="">
                </div>
                <div class="num">
                    <p>充值数量</p>
                    <input type="text" placeholder="请输入">
                </div>
                <div class="upload">
                    <p class="upload-title">上传支付详情截图</p>
                    <van-uploader class="loan-upload" :after-read="afterRead" image-fit="cover" v-model="fileList[0]"
                        reupload max-count="1" upload-icon="/src/assets/img/upload/upload.png">
                    </van-uploader>
                </div>
                <p class="recharge-btn">
                    确认充值
                </p>
            </div>
        </div>
    </div>
</template>

<script>
import qrCode from '@/assets/img/tmp/qrcode.png'
import { showToast } from 'vant';
export default {
    data() {
        return {
            headerTitle: '充值',
            fileList: [],
            accountRecharge: {
                address: 'TDkAnyGrMH7xfGKdpwoVCzMroCCnbk9um3',
                name: 'USDT-TRC20',
                id: 1,
                qr_code: qrCode,
            }
        }
    },
    methods: {
        afterRead(file) {
            console.log(file)
        },
        async copy() {
            try {
                await navigator.clipboard.writeText(this.accountRecharge.address);
                showToast('复制成功');
            } catch (err) {
                showToast('复制失败');
            }

        },
        goPath(path) {
            this.$router.push(path)
        }
    }
}
</script>

<style lang="scss" scoped>
.recharge-apply {
    .recharge-apply-content {
        padding-top: 4.6rem;

        .qr-code {
            text-align: center;
            padding: 2rem 0;
            border-bottom: 1px solid var(--color-border2);

            img {
                width: 16rem;
                height: 16rem;
                border: 1px solid var(--color-icon);
            }
        }

        .recharge-apply-detail {
            padding: 2rem 1.5rem 0;

            .name {
                margin-bottom: 1rem;
                color: var(--color-text3);
            }

            .address {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 1rem;

                p {
                    font-weight: bold;
                }

                img {
                    width: 1.6rem;
                    height: 1.6rem;
                }
            }

            .num {
                margin-bottom: 1rem;

                p {
                    margin-bottom: 1rem;
                    color: var(--color-text3);
                }

                input {
                    width: 100%;
                    border: 1px solid var(--color-border2);
                    padding: 1rem;
                    outline: none;
                }
            }

            .upload {
                .upload-title {
                    margin-bottom: 1rem;
                    color: var(--color-text3);
                }

                .loan-upload {
                    border: 1px solid var(--color-border2);
                    height: 15rem;
                }
            }

            .recharge-btn {
                margin: 2rem 0;
                background: var(--color-icon);
                color: #fff;
                text-align: center;
                padding: 1rem;
                border-radius: .5rem;
            }

        }
    }
}
</style>