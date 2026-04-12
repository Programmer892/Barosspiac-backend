import pool from '../config/db.js';

const getNotifications = async (req, res) => {
    const user_id = req.user.user_id;

    try {
        const [notifications] = await pool.query(
            `SELECT notifications.* 
            FROM notifications
            JOIN users ON users.user_id = notifications.user_id
            WHERE notifications.user_id = ?
            AND (
                (notifications.type = 'new_message' AND users.notify_message = 1)
                OR
                (notifications.type = 'new_rating' AND users.notify_rating = 1)
                OR
                (notifications.type = 'product_sold' AND users.notify_sold = 1)
                OR
                (notifications.type = 'report') 
            )
            ORDER BY notifications.created_at DESC`,
            [user_id]
        );

        res.status(200).json(notifications);
    } catch (error) {
        console.error('Error fetching notifications:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}

const markNotificationAsRead = async (req, res) => {
    const notification_id = req.params.notification_id;

    try {
        await pool.query(
            `UPDATE notifications SET is_read = 1 WHERE notification_id = ?`,
            [notification_id]
        );
        res.status(200).json({ message: 'Notification marked as read' });
    } catch (error) {
        console.error('Error marking notification as read:', error);
        res.status(500).json({ error: 'Internal server error' });
    }

}

const markAllNotificationsAsRead = async (req, res) => {
    const user_id = req.user.user_id;

    try {
        await pool.query(
            `UPDATE notifications SET is_read = 1 WHERE user_id = ?`,
            [user_id]
        );
        res.status(200).json({ message: 'All notifications marked as read' });
    } catch (error) {
        console.error('Error marking all notifications as read:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}

const deleteNotification = async (req, res) => {
    const notification_id = req.params.notification_id;
    try {
        await pool.query(
            `DELETE FROM notifications WHERE notification_id = ?`,
            [notification_id]
        );
        res.status(200).json({ message: 'Notification deleted' });
    } catch (error) {
        console.error('Error deleting notification:', error);
        res.status(500).json({ error: 'Internal server error' });
    }

}


export { getNotifications, markNotificationAsRead, markAllNotificationsAsRead, deleteNotification }