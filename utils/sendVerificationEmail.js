import transporter from '../config/mailer.js'
import crypto from 'crypto'
import pool from '../config/db.js'

export const sendVerificationEmail = async (user_id, email) => {
 
    const token = crypto.randomBytes(32).toString('hex')
    const expires_at = new Date(Date.now() + 24 * 60 * 60 * 1000) // 24 óra


    await pool.query(
        'INSERT INTO email_verifications (user_id, token, expires_at) VALUES (?, ?, ?)',
        [user_id, token, expires_at]
    )

  
    await transporter.sendMail({
        from: '"BarossPiac" <barosspiac@gmail.com>',
        to: email,
        subject: 'Erősítsd meg az email címed — BarossPiac',
        html: `
            <div style="font-family: Arial, sans-serif; max-width: 500px; margin: 0 auto;">
                <h2 style="color: #3b82f6;">BarossPiac</h2>
                <p>Szia! Kattints az alábbi gombra az email cím megerősítéséhez:</p>
                <a href="${process.env.FRONTEND_URL}/api/user/verify-email?token=${token}"
                   style="display: inline-block; background: #3b82f6; color: white; padding: 12px 24px; border-radius: 8px; text-decoration: none; font-weight: bold;">
                    Email megerősítése
                </a>
                <p style="color: #666; font-size: 12px; margin-top: 20px;">
                    A link 24 óráig érvényes. Ha nem te regisztráltál, hagyd figyelmen kívül ezt az emailt.
                </p>
            </div>
        `
    })
}